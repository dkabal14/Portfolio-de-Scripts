#Script escrito por Diego Rosário Sousa
#Cria notificações no Windows 10
Add-Type -AssemblyName System.Windows.Forms


function NovaNotificacao
{
    param
    (
        [Parameter(Mandatory=$true)] [string] $Texto,
        [Parameter(Mandatory=$true)] [string] $Titulo,
        [Parameter(Mandatory=$false)] [string] $Tipo = "Info",
        [Parameter(Mandatory=$false)] [int32] $TempoDeExibicao = 30000
    )

    
    $global:balloon = New-Object System.Windows.Forms.NotifyIcon
    $Path = (Get-Process -id $PID).Path
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($Path)
    if ($Tipo -eq "Info")
    {
        $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
    }
    if ($Tipo -eq "Warning")
    {
        $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning
    }
    if ($Tipo -eq "Error")
    {
        $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Error
    }
    if ($Tipo -eq "None")
    {
        $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::None
    }
    $balloon.BalloonTipText = $texto
    $balloon.BalloonTipTitle = $titulo
    $balloon.Visible = $true
    $balloon.ShowBalloonTip($TempoDeExibicao)
}

<#
    $texto = "Seu chamado foi enviado para a equipe DT_SONDA_SUPORTE_NIVEL3RJ"
    $titulo = "Chamado 21343412"
    $Tipo = "Info"
    $Tipo = "Error"
    $Tipo = "Warning"
    $TempoDeExibicao = 50000
#>

if ($null -ne $args[0])
{
    $texto = $args[0]
}
if ($null -ne $args[1])
{
    $titulo = $args[1]
}
if ($null -ne $args[2])
{
    $tipo = $args[2]
}
if ($null -ne $args[3])
{
    $texto = $args[3]
}

NovaNotificacao -Texto $texto -Titulo $titulo -Tipo $tipo
