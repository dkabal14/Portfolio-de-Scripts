$lista32 = @()
$lista64 = @()
$nomes32 = get-childitem "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach {$_.Name}
$nomes64 = get-childitem "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach {$_.Name}
foreach ($nome in $nomes64)
{
    $txt = $nome.Split("\")
    $lgth = $txt.Length
    $nvNome = $txt[($lgth - 1)]
    $lista64 +=  $nvNome
    $
}

foreach ($nome in $nomes32)
{
    $txt = $nome.Split("\")
    $lgth = $txt.Length
    $nvNome = $txt[($lgth - 1)]
    $lista32 +=  $nvNome
}

foreach ($obj in $lista64)
{
    $java8 = Get-ItemProperty -path "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$obj" | Where-Object {$_.displayname -like "*Java 8*"}
    foreach ($java in $java8)
    {
        $argument = ($java.UninstallString).Split(" ")[1]
        start-process -wait -FilePath "C:\windows\System32\msiexec.exe" -ArgumentList $argument,/qn
    }
}

foreach ($obj in $lista32)
{
    $java8 = Get-ItemProperty -path "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$obj" | Where-Object {$_.displayname -like "*Java 8*"}
    foreach ($java in $java8)
    {
        $argument = ($java.UninstallString).Split(" ")[1]
        start-process -wait -FilePath "C:\windows\System32\msiexec.exe" -ArgumentList $argument,/qn
    }
}