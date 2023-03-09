#Script escrito por Diego Rosário Sousa
#diegorosariosousa@gmail.com

$Credenciais = Get-Credential
$Computers = Get-Content -Path $PSScriptRoot\MoveAD_Em_Massa_Lista.txt
$server = "contoso.net.us"

Foreach ($Computer in $Computers)
{
    if ($Computer -notlike "#*")
    {
        Get-ADComputer -Filter {Name -eq $Computer} -Credential $Credenciais -Properties * -server $server -SearchScope Subtree -SearchBase 'OU=Stations,DC=contoso,DC=net,DC=us' -OutVariable $teste | Select-Object -Property Name,CanonicalName
    }
}
