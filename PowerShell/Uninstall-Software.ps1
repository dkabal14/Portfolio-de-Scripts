function Uninstall-ObjectList
{
    $uninstall = Get-ChildItem Microsoft.Powershell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall

    $hash = @()

    foreach ($Item in $uninstall)
    {
        $FullName = $Item.Name
        $nName = $FullName.split("\")
        $Name = $nName[$nName.length - 1]
        $Properties = Get-ItemProperty -Path "Microsoft.Powershell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$($Name)"
        $DisplayName = $Properties.DisplayName
        $Publisher = $Properties.Publisher
        $UninstallString = $Properties.UninstallString
        

        $temp = @{
            Name = $Name
            DisplayName = $DisplayName
            Publisher = $Publisher
            UninstallString = $UninstallString
        }
        $hash += New-Object -TypeName psobject -Property $temp
    }
    $hash | Select-Object -Property Name, DisplayName, Publisher, UninstallString
}

$desinstalar = "*Bizagi*"
$lista = Uninstall-ObjectList | Where-Object {$_.DisplayName -like $desinstalar}
Start-Process -FilePath "C:\Windows\System32\cmd.exe" -ArgumentList "/c msiexec /x$($lista.Name) /qn"
