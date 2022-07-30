$lista = Get-Content -Path D:\Encontra_Hostname_Lista.txt
foreach ($etiquetaDeTI in $lista)
{
    $filtro = 'Name -like "*' + $etiquetaDeTI + '"'
    (Get-ADComputer -Filter $filtro).Name
}
