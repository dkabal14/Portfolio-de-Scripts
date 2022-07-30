$i = 0
while ($i -eq 0)
{
    $HIDServ = Get-Service -Name hidserv
    if ($hidserv.Status -like "Stopped")
    {
        Set-Service -Name HIDServ -StartupType Automatic
        Start-Service HIDServ
        Write-Host Subiu!
    }
    else
    {
        Start-Sleep -Seconds 1
    }
}