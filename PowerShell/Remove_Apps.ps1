$AppPackages  = @()
$AppPackages += 'Microsoft.BingFinance'
$AppPackages += 'Microsoft.BingNews'
$AppPackages += 'Microsoft.BingSports'
$AppPackages += 'Microsoft.Getstarted'
$AppPackages += 'Microsoft.MicrosoftOfficeHub'
$AppPackages += 'Microsoft.MicrosoftSolitaireCollection'
$AppPackages += 'Microsoft.Office.OneNote'
$AppPackages += 'Microsoft.People'
$AppPackages += 'Microsoft.SkypeApp'
$AppPackages += 'Microsoft.XboxGameCallableUI'
$AppPackages += 'Microsoft.XboxIdentityProvider'
$AppPackages += 'microsoft.windowscommunicationsapps'
$AppPackages += 'Microsoft.WindowsPhone'
$AppPackages += 'Microsoft.XboxApp'
$AppPackages += 'Microsoft.ZuneMusic'
$AppPackages += 'Microsoft.ZuneVideo'
$AppPackages += 'Microsoft.BingWeather'


#$AppPackages += 'Microsoft.MicrosoftEdge'
#$AppPackages += 'Microsoft.Windows.Photos'
#$AppPackages += 'Microsoft.Windows.ParentalControls'
#$AppPackages += 'Microsoft.WindowsFeedback'
#$AppPackages += 'Windows.ContactSupport'
#$AppPackages += 'Windows.PurchaseDialog'
#$AppPackages += 'Microsoft.WindowsCamera'
#$AppPackages += 'Microsoft.WindowsMaps'
#$AppPackages += 'WindowsAlarms'
#$AppPackages += 'Microsoft.3DBuilder'

foreach ($App In $AppPackages) {

    $Package = Get-AppxPackage | Where-Object {$_.Name -eq $App}
    If ($null -ne $Package) {
        Write-Host "Removing Package : $App"
        Remove-AppxPackage -Package $Package.PackageFullName -ErrorAction SilentlyContinue
    }
    Else {
        Write-Host "Requested Package is not installed : $App"
    }

    $ProvisionedPackage = Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq $App}
        If ($null -ne $ProvisionedPackage) {
        Write-Host "Removing Provisioned Package : $App"
        Remove-AppxProvisionedPackage -Online -PackageName $ProvisionedPackage.PackageName -ErrorAction SilentlyContinue
    }
    Else {
        Write-Host "Requested Provisioned Package is not installed : $App"
    }

}