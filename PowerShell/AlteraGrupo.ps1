#Script criado por Diego por Diego Ros�rio Sousa - Suporte N�vel 3 - RJa
#diegos.sonda@contratada.oi.net.br
#

$contador = 1
$grupos = Get-LocalGroup | Select-Object @{Name = 'Id';Expression = {$Global:contador;$Global:contador++}},Name,Description
foreach ($grupo in $grupos)
{
    $grupo
}
