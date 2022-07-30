$NomeDoSoftware = "%Umbrella%"
$lista = "
DSKCORPRJ116549
"

#==================================== LISTA DE M�QUINAS ========================================


$lista = $lista.Replace("`r","/").Replace("`n","\")
$lista = $lista.Substring(2,$lista.Length - 4).Split("/\")

foreach ($hostname in $lista)
{
    $product = Get-WmiObject -Query "Select * from Win32_Product Where Name like '$($NomeDoSoftware)'" -ComputerName $hostname
    $result = $product.uninstall()
    if ($result.ReturnValue -ne 0)
    {
        Write-Host "A desinstalação do software $($product.Name), no equipamento $($hostname), falhou" -ForegroundColor Red
    }
    else
    {
        Write-Host "A desinstalação do software $($product.Name), no equipamento $($hostname), obteve sucesso" -ForegroundColor Green
    }
    #wmic /node:"DSKOFCORJ070027" product where "name like 'Smart Offices'" call uninstall /nointeractive
}