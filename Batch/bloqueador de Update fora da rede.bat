REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization\Config" /t REG_DWORD /v DODownloadMode /d 00000001 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /t REG_DWORD /v DODownloadMode /d 00000001 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /t REG_DWORD /v DoNotConnectToWindowsUpdateInternetLocations /d 00000001 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /t REG_DWORD /v DisableWindowsUpdateAccess /d 00000001 /f