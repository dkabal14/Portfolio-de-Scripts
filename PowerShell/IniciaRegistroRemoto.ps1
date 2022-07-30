$computadores = @()
$computadores += "DSKCCPAPR032638"
$computadores += "DSKCCPAPR032642"
$computadores += "DSKCCPAPR032611"
$computadores += "DSKCCPAPR032615"
$computadores += "DSKCCPAPR032602"
$computadores += "DSKCCPAPR032609"
$computadores += "DSKCCPAPR032622"
$computadores += "DSKCCPAPR032624"
$computadores += "DSKCCPAPR032629"
$computadores += "DSKCCPAPR032631"
$computadores += "DSKCCPAPR032634"
$computadores += "DSKCCSUPR032616"
$computadores += "DSKCCSUPR032633"

ForEach ($computador in $computadores)
{
    $RemoteRegistry = Get-WmiObject -ComputerName $computador -class Win32_Service | Where-Object {$_.Name -eq "RemoteRegistry"}
    $RemoteRegistry.ChangeStartMode("Automatic")
    $RemoteRegistry.StartService()
}