SET BP=%~dp0
CD /D %BP%
powershell Set-ExecutionPolicy Unrestricted LocalMachine -Force
PowerShell .\PowerShell\InstalaAD_Offline.ps1
pause