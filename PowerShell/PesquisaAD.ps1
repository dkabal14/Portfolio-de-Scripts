$nomeComputador = Read-Host -Prompt "Digite o nome do computador a ser pesquisado, caso seja o seu próprio micro, digite '.'"
if ($nomeComputador -eq '.') {$nomeComputador = $env:COMPUTERNAME}
$strFiltro = "(&(objectClass=Computer)(objectCategory=Computer)(cn=$nomeComputador))"
$objDominio = New-Object System.DirectoryServices.DirectoryEntry
$objPesquisador = New-Object System.DirectoryServices.DirectorySearcher
$objPesquisador.Filter = $strFiltro
$objPesquisador.SearchScope = 'Subtree'
$objPesquisador.SearchRoot = $objDominio
$objObjetoAD = $objPesquisador.FindOne().Properties.distinguishedname
Write-Host $objObjetoAD -ForegroundColor Green