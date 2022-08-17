$Pesquisa = Read-Host -Prompt "Digite a pesquisa do site Poring"
#Conexão
$Site = "https://poring.world/api/search?order=popularity&rarity=&inStock=1&modified=&category=&endCategory=&q=$Pesquisa"
$Proxy = "http://10.21.7.10:82"

$sair = $false
Do
{
    "Data Atual: `n" + (Get-Date)
    "================================"
    $WRequest = Invoke-WebRequest -Uri $Site -Proxy $Proxy -ProxyUseDefaultCredentials
    $json = $WRequest.Content | ConvertFrom-Json
    $json | Select-Object -Property Name, @{N="Price";E={$_.lastRecord.Price}}, @{N="TimeStamp";E={(New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0).AddSeconds($_.lastRecord.TimeStamp)}}
    $json = $null
    Start-Sleep -Seconds 5
}
While ($sair -eq $false)