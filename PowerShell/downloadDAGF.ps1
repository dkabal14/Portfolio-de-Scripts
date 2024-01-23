foreach ($i in (0..9)) {
    Write-Host -
    Invoke-WebRequest -Uri "https://dadosabertos.rfb.gov.br/CNPJ/Empresas$i.zip" -OutFile "Empresas$i.zip"
    Invoke-WebRequest -Uri "https://dadosabertos.rfb.gov.br/CNPJ/Socios$i.zip" -OutFile "Socios$i.zip"
}