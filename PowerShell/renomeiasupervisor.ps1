$Supervisor = Get-LocalUser -Name supervisor
$Builtin = $localUsers | Select-Object -Property * | Where-Object {$_.SID -like "*-500"}
$Senha_Administrador = ConvertTo-SecureString "#SUPPORT13s123" -AsPlainText -Force
if ($Builtin.Name -like "Admin*")
{
    if ($Supervisor -ne $null) #O Built-in está com nome Admin e o supervisor existe
    {
        Rename-LocalUser -Name "supervisor" -NewName "nAdministrador"
        Rename-LocalUser -Name $Builtin.Name -NewName "Supervisor"
        Rename-LocalUser -Name "nAdministrador" -NewName "Administrador"
        Get-LocalUser -Name "supervisor" | Enable-LocalUser
    }
    else # O Built-in está com nome Admin e o supervisor não existe
    {
        Rename-LocalUser -Name $Builtin.Name -NewName "Supervisor"
        New-LocalUser -Name Administrator -Password $Senha_Administrador -AccountNeverExpires -UserMayNotChangePassword -Description "Conta interna para a administração do computador/domínio" -PasswordNeverExpires -Disabled
        Get-LocalUser -Name supervisor | Enable-LocalUser
    }

}
#else #Built-in não está com nome de admin