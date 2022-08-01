#Script escrito por Diego Rosário Sousa - Suporte Nível 3 RJ
#diegorosariosousa@gmail.com

$Credenciais = Get-Credential
$Computers = Get-Content -Path $PSScriptRoot\MoveAD_Em_Massa_Lista.txt

Foreach ($Computer in $Computers)
{
    if ($Computer -notlike "#*")
    {
        Get-ADComputer -Filter {Name -eq $Computer} -Credential $Credenciais -Properties * -server oi.corp.net -SearchScope Subtree -SearchBase 'OU=Estacoes,DC=oi,DC=corp,DC=net' -OutVariable $teste | Select-Object -Property Name,CanonicalName
    }
}
