# Create new local Admin user for script purposes
$Computer = [ADSI]"WinNT://$Env:COMPUTERNAME,Computer"
$LocalAdmin = $Computer.Create("User", "LocalAdmin")
$LocalAdmin.SetPassword("Password01")
$LocalAdmin.SetInfo()
$LocalAdmin.FullName = "Local Admin by Powershell"
$LocalAdmin.SetInfo()
$LocalAdmin.UserFlags = 64 + 65536 # ADS_UF_PASSWD_CANT_CHANGE + ADS_UF_DONT_EXPIRE_PASSWD
$LocalAdmin.SetInfo()