

Function Move-Maquina
{
    param ([string]$Máquina)
    $objeto = Get-ADComputer -Filter {Name -eq $Maquina} -Properties * -Server oi.corp.net -SearchScope Subtree -SearchBase 'OU=Estacoes,DC=oi,DC=corp,DC=net' | Select-Object -Property Name
    $strFiltro = "(&(objectClass=Computer)(objectCategory=Computer)(cn=$Maquina))"
    $objDominio = New-Object System.DirectoryServices.DirectoryEntry
    $objPesquisador = New-Object System.DirectoryServices.DirectorySearcher
    $objPesquisador.Filter = $strFiltro
    $objPesquisador.SearchScope = 'Subtree'
    $objPesquisador.SearchRoot = $objDominio
    $ObjetoAD = $objPesquisador.FindOne().Properties.distinguishedname
    $objAlvo = "OU=,OU=Estacoes,DC=oi,DC=corp,DC=net"
    Move-ADObject -Identity "$ObjetoAD" -TargetPath $objAlvo
    Write-Host " Objeto $Computer" -ForegroundColor Cyan
    Write-Host "     OU Anterior: $ObjetoAD `n     OU Atual:    $objAlvo`n" -ForegroundColor Green
}

$MaquinaAtual = $env:COMPUTERNAME
$HostPadrao = "DSKPSRDSP"
$PadraoLocal = $MaquinaAtual.Substring(0, 9)

#if ($PadraoLocal -ne $MaquinaAtual)
#{
#    Write-Host "O nome da máquina deve estar errado!. Coloque o nome certo." -ForegroundColor Yellow
#    C:\Windows\System32\SystemPropertiesComputerName.exe
#}
if ($MaquinaAtual.Length -lt 15)
{
    Write-Host "O nome da máquina deve estar errado!. Coloque o nome certo." -ForegroundColor Yellow
    C:\Windows\System32\SystemPropertiesComputerName.exe
}