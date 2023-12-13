$agendamento = get-date $args[0]
$pasta = "C:\Windows\CCM"
$arquivo = "Reboot_SmartOffice.log"

if ((Test-Path "$pasta\$arquivo") -ne $true)
{
    do 
    {
        if ((Get-Date) -ge $agendamento)
        {
            New-Item -Path $pasta -Name $arquivo
            Restart-Computer -Force
        }
        Start-Sleep -Seconds 5
    }
    while ((Test-Path -Path C:\Windows\CCM\Reboot_SmartOffice.log) -eq $false)
}