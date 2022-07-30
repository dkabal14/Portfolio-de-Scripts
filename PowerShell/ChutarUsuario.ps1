#Script created by Diego Sousa
#Esse script possui duas funções, a primeira (Get-Session) faz um scrapping do comando Query Session e coloca o resultaod em um objeto, facilitando o kick nos usuários logados em máquinas locais e/ou remotas, a segunda, executa o logoff em um perfil escolhido.

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

function LogoffUser
{
    param (
        # Nome da sessão, ver query session
        [Parameter(Mandatory=$false,Position=0)]
        [string]
        $SessionName,
        # Nome do usuário, ver query session
        [Parameter(Mandatory=$false,Position=0)]
        [string]
        $UserName,
        # ID de sessão, ver query session
        [Parameter(Mandatory=$false,Position=0)]
        [string]
        $SessionID,
        # Pra deslogar todos os usuários com certo estado
        [Parameter(Mandatory=$false,Position=0)]
        [string]
        [ValidateSet("Disco","Conn","Ativo","Escutar")]
        $State,
        # computador remoto
        [Parameter(Mandatory=$false,Position=1)]
        [string]
        $ComputerName
    )

    
    if ($null -ne $SessionName)
    {
        if ($item.UserName -ne "")
            {
                $statusUsuario = "Sendo utilizada pelo usuário $($item.UserName)"
            }
            else 
            {
                $statusUsuario = "Sem nome de usuário para a sessão"                
            }
            "==================================================="
            Write-Host "Deslogando a sessão $($item.SessionID), $($statusUsuario)" -ForegroundColor Green
            if ($null -eq $ComputerName)
            {
                logoff $item.SessionID
            }
            else
            {
                logoff $item.SessionID /SERVER:$ComputerName
            }
    }
    elseif ($null -ne $State)
    {
        $lista = Get-Session | Where-Object {$_.State -eq $State}
        foreach ($item in $lista) {
            if ($item.UserName -ne "")
            {
                $statusUsuario = "Sendo utilizada pelo usuário $($item.UserName)"
            }
            else 
            {
                $statusUsuario = "Sem nome de usuário para a sessão"                
            }
            "==================================================="
            Write-Host "Deslogando a sessão $($item.SessionID), $($statusUsuario)" -ForegroundColor Green
            if ($null -eq $ComputerName)
            {
                logoff $item.SessionID
            }
            else
            {
                logoff $item.SessionID /SERVER:$ComputerName
            }
        }
    }
}

$session = Get-Session
if ($session.UserName -eq "tc057318")
{
    write-host $true -ForegroundColor Green
}
else 
{
    write-host $false -ForegroundColor Red
}
Get-Session
