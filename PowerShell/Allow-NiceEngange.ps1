function InstallNetFrameWork #Instala o .NetFramework cujo instalador está na pasta do script
{
    Start-Process -FilePath "$($PSScriptRoot)\NDP47-KB3186497-x86-x64-AllOS-ENU.exe" -ArgumentList "/passive","/norestart" -Wait
}

function AllowNiceEngage #Cria as regras de entrada que permitem a comunicação do Nice Engage
{
    $lista = @("TCP,443","TCP,2010","UDP,5060","UDP,5062","UDP,5063","TCP,62070","TCP,62122","TCP,62124","TCP,62130","UDP,38210-38220","UDP,62125")

    #$Programa = "C:\windows\notepad.exe"
    $Nome = "Nice_Engage"

    foreach ($item in $lista)
    {
        $parameters = $item.Split(",")
        $protocolo = $parameters[0]
        $portas = $parameters[1]
        Write-Host "Criando regra para o protocolo $($protocolo) e porta $($portas)" -ForegroundColor Yellow
        New-NetFirewallRule -Name "$($Nome)_$($portas)" -DisplayName "$($Nome)_$($portas)" -Enabled True -Profile Any -Direction Inbound -Action Allow -Protocol $protocolo -RemotePort $portas
    }
}

function InstallNiceEngage #Inicia a instalação do Nice Engage
{
    Write-Host "Instalando o Nice Engage" -ForegroundColor Yellow
    $OS = Get-CimInstance -ClassName Win32_OperatingSystem
    if ($OS.OSArchitecture -eq "64 bits")
    {
        Start-Process -FilePath "$($PSScriptRoot)\ScreenAgentXP64.msi" -ArgumentList "/qn","/norestart" -Wait
    }
    else
    {
        Start-Process -FilePath "$($PSScriptRoot)\ScreenAgentXP.msi" -ArgumentList "/qn","/norestart" -Wait
    }
}

function InstallVisualC #Instala o Visual C++ que está na pasta do software
{
    Start-Process -FilePath "$PSScriptRoot\Visual2017(x86).exe" -ArgumentList "/passive","/norestart" -Wait
}

InstallNetFrameWork
AllowNiceEngage
InstallVisualC
InstallNiceEngage