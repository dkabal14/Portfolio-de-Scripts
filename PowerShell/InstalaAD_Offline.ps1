#Ativar o Active Directory 20H2
<#
    CASO A CONEXÃO NÃO PEGUE O NOME DOSA RQUIVOS ONLINE
    $rsatNames = @()
    $rsatNames += "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.BitLocker.Recovery.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.CertificateServices.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.DHCP.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.Dns.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.FailoverCluster.Management.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.FileServices.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.IPAM.Client.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.LLDP.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.NetworkController.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.NetworkLoadBalancing.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.RemoteAccess.Management.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.RemoteDesktop.Services.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.ServerManager.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.Shielded.VM.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.StorageMigrationService.Management.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.StorageReplica.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.SystemInsights.Management.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.VolumeActivation.Tools~~~~0.0.1.0"
    $rsatNames += "Rsat.WSUS.Tools~~~~0.0.1.0"
#>
 

Stop-Service 'wuauserv'
 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DisableWindowsUpdateAccess" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DoNotConnectToWindowsUpdateInternetLocations" -Type DWord -Value 0
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUServer" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUStatusServer" -ErrorAction SilentlyContinue
Start-Service 'wuauserv'

$ISO = Get-ChildItem -Path $PSScriptRoot | ForEach-Object {$_.FullName}
Mount-DiskImage -ImagePath $ISO
$DriveDoDisco = Get-PSDrive | Select-Object -Property * -Unique | Where-Object {$_.Description -eq "FOD_PT1_x64FRE_EN-US_DV9"}
$RSATComponents= Get-WindowsCapability -Name RSAT* -Online


foreach ($RSATComponent in $RSATComponents )
{
    "================================================================="
    $message = "Instalando " + $RSATComponent.Name + ":" + "`n`n" + $RSATComponent.DisplayName + "`n`n"
    Write-Host $message
    $Nome = $RSATComponent.Name
    $Source = $DriveDoDisco.Root
    dism /Online /Add-Capability /CapabilityName:$Nome /Source:$Source

    "================================================================="
}
Dismount-DiskImage -ImagePath $ISO
Stop-Service 'wuauserv'
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DisableWindowsUpdateAccess" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DoNotConnectToWindowsUpdateInternetLocations" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUServer" -Type String -Value "http://SCMPW11.oi.corp.net:8530"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUStatusServer" -Type String -Value "http://SCMPW11.oi.corp.net:8530"