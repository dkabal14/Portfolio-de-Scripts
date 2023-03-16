
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
function input-grafico($vTexto,$vTitulo)
{
    $titulo = $vTitulo
    $texto = $vTexto
    $inputForm = New-Object System.Windows.Forms.Form
    $inputForm.Text = $titulo
    $inputForm.Size = New-Object System.Drawing.Size(350,150)
    $inputForm.StartPosition = 'CenterScreen'
    $lb = New-Object System.Windows.Forms.Label
    $lb.Location = New-Object System.Drawing.Point(20,20)
    $lb.Size = New-Object System.Drawing.Size(240,20)
    $lb.Text = $texto
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
function Renomear-Computador {
    $novoNome = input-grafico('Informe o novo nome do equipamento abaixo:','Renomeando o Equipamento')
    Rename-Computer -NewName $novoNome -Force
}
function Cria-usuariolocalADM #Cria um usuário local chamado AdminTemporario com a senha #SUPPORT13s123
{
    $Computer = [ADSI]"WinNT://$Env:COMPUTERNAME,Computer"
    $LocalAdmin = $Computer.Create("User", "AdminTemporario")
    $LocalAdmin.SetPassword("#SUPPORT13s123")
    $LocalAdmin.SetInfo()
    $LocalAdmin.FullName = "Admin criado através de um script"
    $LocalAdmin.SetInfo()
    $LocalAdmin.UserFlags = 64 + 65536 # ADS_UF_PASSWD_CANT_CHANGE + ADS_UF_DONT_EXPIRE_PASSWD
    $LocalAdmin.SetInfo()
    Add-LocalGroupMember -Group Administradores -Member AdminTemporario
}
Function Remove-usuariolocalADM #Remove o usuário AdminTemporario (não implementado)
{
    Remove-LocalUser -Name "AdminTemporario"
}

function MexeNoDominio($DominioAtual) #Se estiver no dominio oi migra, se não para o script
{
    if ($DominioAtual -eq "oi.corp.net")
    {
        $Credenciais = Get-Credential -Message "Digite a credencial para remoção do domínio"
        Add-Computer -Credential $Credenciais -DomainName corporativo.global.root
    }
    elseif ($DominioAtual -eq "corporativo.global.root")
    {
        Write-Host "Equipamento já está no domínio Vtal" -ForegroundColor Yellow
    }
    else 
    {
        Write-Host "Equipamento está fora de qualquer domínio" -ForegroundColor Red
    }
}

#Parte onde o script é executado de fato
$DominioAtual = Get-ComputerInfo | foreach {$_.csdomain}
Cria-usuariolocalADM
Renomear-Computador
MexeNoDominio($DominioAtual)
