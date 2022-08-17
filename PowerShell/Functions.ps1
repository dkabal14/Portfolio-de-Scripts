Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
function input-grafico()
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $Titulo,
        [Parameter(Mandatory=$false)]
        [string]
        $Texto
    )
    $inputForm = New-Object System.Windows.Forms.Form
    $inputForm.Text = $Titulo
    $inputForm.Size = New-Object System.Drawing.Size(350,150)
    $inputForm.StartPosition = 'CenterScreen'
    $lb = New-Object System.Windows.Forms.Label
    $lb.Location = New-Object System.Drawing.Point(20,20)
    $lb.Size = New-Object System.Drawing.Size(240,20)
    $lb.Text = $Texto
    $inputForm.Controls.Add($lb)
    $tb1 = New-Object System.Windows.Forms.TextBox
    $tb1.Location = New-Object System.Drawing.Point(20,40)
    $tb1.Size = New-Object System.Drawing.Size(240,20)
    $inputForm.Controls.Add($tb1)
    $okb = New-Object System.Windows.Forms.Button
    $okb.Location = New-Object System.Drawing.Point(20,65)
    $okb.Size = New-Object System.Drawing.Size(75,25)
    $okb.Text = 'Ok'
    $okb.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $inputForm.AcceptButton = $okb
    $inputForm.Controls.Add($okb)
    $inputForm.Topmost = $true
    $inputForm.Add_Shown({$tb1.Select()})
    $rs = $inputForm.ShowDialog()
    if ($rs -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $result = $tb1.Text
        return $result
    }
}
function Cria-usuariolocalADM($vUserName,$vSenha,$vNomeCompleto) #Cria um usuário local chamado AdminTemporario com a senha #SUPPORT13s123
{
    $Computer = [ADSI]"WinNT://$Env:COMPUTERNAME,Computer"
    $LocalAdmin = $Computer.Create("User", $vUserName)
    $LocalAdmin.SetPassword($vSenha)
    $LocalAdmin.SetInfo()
    $LocalAdmin.FullName = $vNomeCompleto
    $LocalAdmin.SetInfo()
    $LocalAdmin.UserFlags = 64 + 65536 # ADS_UF_PASSWD_CANT_CHANGE + ADS_UF_DONT_EXPIRE_PASSWD
    $LocalAdmin.SetInfo()
    Add-LocalGroupMember -Group Administradores -Member $vUserName
}
function Get-Session
{
    param (
        [Parameter(Mandatory=$False)]
        [String]
        $ComputerName
    )

    if ($null -eq $ComputerName)
    {
        $qwinsta = query Session
        $i = 0
        $objQwinsta = @()

        foreach ($item in $qwinsta)
        {
            if ($i -ne 0)
            {
                $item = $item -replace "\s+",","
                #$item = $item -replace ">",""
                $item = $item.Substring(1,($item.Length - 2))
                $item = $item.Split(",")
                switch ($item.Length) {
                    4
                    {
                        $temp = @{
                            SessionName = $item[0]
                            UserName = $item[1]
                            ID = $item[2]
                            State = $item[3]
                        }
                        $objQwinsta += New-Object -TypeName psobject -Property $temp
                    }
                    3 
                    {
                        $temp = @{
                            SessionName = $item[0]
                            UserName = ""
                            ID = $item[1]
                            State = $item[2]
                        }
                        $objQwinsta += New-Object -TypeName psobject -Property $temp
                    }
                }
            }
            $i = $i + 1
        }
        $i = $null
        $objQwinsta = $objQwinsta | Select-Object -Property SessionName,UserName,ID,State
        $objQwinsta
    }
    else 
    {
        $qwinsta = query Session /server:$ComputerName
        $i = 0
        $objQwinsta = @()
    
    
        foreach ($item in $qwinsta)
        {
            if ($i -ne 0)
            {
                $item = $item -replace "\s+",","
                #$item = $item -replace ">",""
                $item = $item.Substring(1,($item.Length - 2))
                $item = $item.Split(",")
                switch ($item.Length) {
                    4
                    {
                        $temp = @{
                            SessionName = $item[0]
                            UserName = $item[1]
                            SessionID = $item[2]
                            State = $item[3]
                        }
                        $objQwinsta += New-Object -TypeName psobject -Property $temp
                    }
                    3 
                    {
                        $temp = @{
                            SessionName = $item[0]
                            UserName = ""
                            SessionID = $item[1]
                            State = $item[2]
                        }
                        $objQwinsta += New-Object -TypeName psobject -Property $temp
                    }
                }
            }
            $i = $i + 1
        }
        $i = $null
        $objQwinsta = $objQwinsta | Select-Object -Property SessionName,UserName,SessionID,State
        $objQwinsta
    }
}

function Get-Profiles
{
    $SIDs = @()
    $Profiles = @()
    $ProfileList = Get-ChildItem -Path "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" | Select-Object -ExpandProperty Name
    foreach ($item in $ProfileList)
    {
        $txt = $item.Split("\")
        $nTXT = $txt[($txt.Length - 1)]
        $SIDs += $nTXT
    }
    foreach ($SID in $SIDs)
    {
        $ProfileImagePath = Get-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$($SID)" | Select-Object -ExpandProperty ProfileImagePath
        $txt = $ProfileImagePath.Split("\")
        $UserName = $txt[($txt.Length - 1)]
        $LastUse = Get-ChildItem -Path "c:\Users\" | Select-Object -Property Name,LastAccessTime | Where-Object {$_.Name -eq $UserName}  | Select-Object -ExpandProperty LastAccessTime
        $temp = @{
            UserName = $UserName
            SID = $SID
            ProfileImagePath = $ProfileImagePath
            LastUse = $LastUse
        }
        $Profiles += New-Object -TypeName psobject -Property $temp
    }
    return $Profiles
}

function Remove-Profiles
{
    [CmdletBinding()]
    param (
        [ValidateSet("Data","Todos")]
        [String]
        $Metodo = "Data"
    )

    switch ($Metodo) {
        Data
        {
            $Excecao = @('Supervisor','Default','Public','SystemProfile','LocalService','NetworkService','Administrador','Administrator')
            $Excecao += (get-session | Where-Object {$_.State -eq "Ativo"}).UserName
            Write-Host "=====================================" -ForegroundColor Green
            Write-Host "Abaixo: Os perfis que serão deletados:" -ForegroundColor Green 
            Write-Host "=====================================" -ForegroundColor Green
            $ProfToDelete = Get-Profiles | Where-Object {$null -ne $_.LastUse -and $_.LastUse -le (Get-Date).AddDays($diasSemUso) -and $Excecao -notcontains $_.UserName}
            
            foreach ($Profile in $ProfToDelete)
            {
                Write-Host "=====================================" -ForegroundColor Green
                Write-Host "Deletando o perfil $($Profile.UserName), utilizado pela última vez em: $($Profile.LastUse)" -ForegroundColor Green
                Get-CimInstance -Query "Select * from Win32_UserProfile Where SID='$($Profile.SID)'" | Remove-CimInstance
                Write-Host "=====================================" -ForegroundColor Green
            }
        }
        Todos
        {
            $Excecao = @('Supervisor','Default','Public','SystemProfile','LocalService','NetworkService','Administrador','Administrator')
            $Excecao += (get-session | Where-Object {$_.State -eq "Ativo"}).UserName
            Write-Host "=====================================" -ForegroundColor Green
            Write-Host "Abaixo: Os perfis que podem ser deletados:" -ForegroundColor Green 
            Write-Host "=====================================" -ForegroundColor Green
            Get-Profiles | Where-Object {$null -ne $_.LastUse -and $Excecao -notcontains $_.UserName} | Select-Object -ExpandProperty UserName
            do
            {
                $Choice = Read-Host -Prompt "`nDeseja adicionar uma exceção? (S/N)"
                if ($Choice -eq "s")
                {
                    do 
                    {
                        $novaExcecao2 = Read-Host -Prompt "Adicione um login a excecao (se já terminou digite N)"
                        if ($novaExcecao2 -ne "N")
                        {
                            if ((Get-Profiles | Select-Object -ExpandProperty UserName) -contains $novaExcecao2)
                            {
                                $Excecao += $novaExcecao2
                            }
                            else 
                            {
                                Write-Host "Não foi possível adicionar o usuário $($novaExcecao2) por quê ele não existe" -ForegroundColor Red
                            }
                        }
                    }
                    until ($novaExcecao2 -eq "N")
                    $Choice = "N"
                }
                elseif ($Choice -eq "n")
                {
                    $Choice = "N"
                }
                else
                {
                    Write-Host "Digite apenas 'S' ou 'N'" -ForegroundColor Red
                }
            }
            until ($Choice -eq "N")
            $ProfToDelete = Get-Profiles | Where-Object {$null -ne $_.LastUse -and $Excecao -notcontains $_.UserName}
            foreach ($Profile in $ProfToDelete)
            {
                Write-Host "=====================================" -ForegroundColor Green
                Write-Host "Deletando o perfil $($Profile.UserName), utilizado pela última vez em: $($Profile.LastUse)" -ForegroundColor Green
                Get-CimInstance -Query "Select * from Win32_UserProfile Where SID='$($Profile.SID)'" | Remove-CimInstance
                Write-Host "=====================================" -ForegroundColor Green
            }
        }
    }
}

function Remove-SCCMCache #Baseado no artigo encontrado em https://enterinit.com/sccm-clean-client-cache-script/
{
    $UIResourceMgr = New-Object -com “UIResource.UIResourceMgr”
    $CacheInfo = $UIResourceMgr.GetCacheInfo()
    $CacheElements = $CacheInfo.GetCacheElements()
    
    foreach ($CacheElement in $CacheElements)
    {
        Write-Host "=====================================" -ForegroundColor Green
        Write-Host "Limpando o pacote $($CacheElement.Location) do cache do SCCM" -ForegroundColor Green
        $CacheInfo.DeleteCacheElement($CacheElement.CacheElementID)
        Write-Host "=====================================" -ForegroundColor Green
    }
}
function Popup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $Mensagem,

        [Parameter(Mandatory=$false)]
        [int32]
        $tempo = 0,

        [Parameter(Mandatory=$false)]
        [validateset("OK","OKCancelar","AnularRepetirIgnorar","SimNaoCancelar","SimNao","RepetirCancelar")]
        $Botao = "OK",

        [Parameter(Mandatory=$false)]
        [string]
        $titulo = "Sem título",

        [Parameter(Mandatory=$false)]
        [string]
        [validateset("Erro","Questionamento","Aviso","Informacao")]
        $Icone = "Informacao"
    )
    $WShell = New-Object -ComObject Wscript.Shell
    switch ($Botao) 
    {
        
        "OK"
        {
            $buttChoice = 0
        }
        "OKCancelar"
        {
            $buttChoice = 1
        }
        "AnularRepetirIgnorar"
        {
            $buttChoice = 2
        }
        "SimNaoCancelar"
        {
            $buttChoice = 3
        }
        "SimNao"
        {
            $buttChoice = 4
        }
        "RepetirCancelar"
        {
            $buttChoice = 5
        }
    }

    switch ($Icone)
    {
        "Erro"
        {
            $IconChoice = 16
        }
        "Questionamento"
        {
            $IconChoice = 32
        }
        "Aviso"
        {
            $IconChoice = 48
        }
        "Informacao"
        {
            $IconChoice = 64
        }
    }
}
function Criar-CertificadoSha1 {
    [CmdletBinding()]
    param (
        [Parameter(mandatory=$false)]
        [string]
        $cerOutput="c:\SHA1.cer",
        [Parameter(mandatory=$true)]
        [string]
        $email,
        [Parameter(mandatory=$false)]
        [validateset("Years","Months","Days","Hours","Minutes","Seconds")]
        [string]
        $ValidityPeriod="Years",
        [Parameter(mandatory=$false)]
        [string]
        $ValidityPeriodUnity="10"
    )
    $infOutput="c:\DocumentEncryption.inf"

    $infInput='    [Version]
    Signature = "$Windows NT$"
    
    [Strings]
    szOID_ENHANCED_KEY_USAGE = "2.5.29.37"
    szOID_DOCUMENT_ENCRYPTION = "1.3.6.1.4.1.311.80.1"
    
    [NewRequest]
    Subject = "cn='+ $email + '"
    MachineKeySet = false
    KeyLength = 2048
    KeySpec = AT_KEYEXCHANGE
    HashAlgorithm = Sha1
    Exportable = true
    RequestType = Cert
    KeyUsage = "CERT_KEY_ENCIPHERMENT_KEY_USAGE | CERT_DATA_ENCIPHERMENT_KEY_USAGE"
    ValidityPeriod = ' + $ValidityPeriod + '
    ValidityPeriodUnits = ' + $ValidityPeriodUnity + '
    
    [Extensions]
    %szOID_ENHANCED_KEY_USAGE% = "{text}%szOID_DOCUMENT_ENCRYPTION%"'


    $infInput | Out-File -FilePath $infOutput #cria o inf
    
    certreq -new $infOutput $cerOutput #cria o certificado atraés do inf
}

