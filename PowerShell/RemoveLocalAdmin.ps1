#Remove usuario local do gupo administradors
$Users=Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'" 
ForEach ($User in $Users)
{  
 if($User.Name -ne "launcher")
 {
  net localgroup Administradores $User.Name /delete
 }
}
 