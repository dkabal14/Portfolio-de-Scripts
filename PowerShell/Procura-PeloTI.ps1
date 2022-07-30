$lista = @("70331","070188","70586","64958")

ForEach ($TI in $lista)
{
    $resultado = $null
    Write-Host "Objeto $($TI)" -ForegroundColor Cyan
    $pesquisa = "*" + $TI + "*"
    $resultado = Get-ADComputer -Filter {Name -like $pesquisa} | ForEach-Object {$_.name}
    
    if ($null -eq $resultado)
    {
        Write-Host "Nenhum hostname encontrado para $($TI)"
    }
    else 
    {
        Write-Host ($resultado) -ForegroundColor Green
    }
    "==========================================================="
}