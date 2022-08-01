#Script escrito por diegorosariosousa@gmail.com
#Script feito para trocar o nome do usuário Administrador built-in (criado com a instalação do Windows) para Supervisor
#Esse script troca qualquer usuário com o nome "supervisor" para Administrador no lugar dele, e caso esse não exista, ele o cria como um Administrador "fake"

$Supervisor = Get-LocalUser -Name supservisor #Verifica se existe um usuário com nome Supervisor
$Builtin = $localUsers | Select-Object -Property * | Where-Object {$_.SID -like "*-500"} #Armazena o objeto do usuário built-in
$Senha_Administrador = ConvertTo-SecureString "#SUPPORT13s123" -AsPlainText -Force #Define a senha do usuário built-in
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
