Set-ExecutionPolicy Unrestricted LocalMachine -Force
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
Set-SmbClientConfiguration -RequireSecuritySignature $true
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecureNegotiate -Value 0 -Force
Start-Sleep -s 60
Exit