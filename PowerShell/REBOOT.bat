set batchpath=%~dp0
cd %batchpath%
Powershell -ExecutionPolicy ByPass -file Reboot_Em_Massa.ps1 "30/07/2021 02:00:00"