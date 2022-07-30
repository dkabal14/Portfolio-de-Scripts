#O script mostra em qual Unidade Organizacional o objeto do equipamento se encontra no Active Directory
#sem a necessidade de instalação do RSAT.
$sair = "nao"
Do
{
    $computador = Read-Host -Prompt "Digite o nome do computador"
    $namespace = "root\RSOP\Computer"
    $class = "RSOP_Session"

    $result = Get-WmiObject -Namespace $nameSpace -Class $class -ComputerName $computador | Select-Object -Property @{label="OU da Máquina";Expression={$_.SOM}}
    Write-Host `n $result `n -ForegroundColor Green
}
While ($sair -eq "nao")
