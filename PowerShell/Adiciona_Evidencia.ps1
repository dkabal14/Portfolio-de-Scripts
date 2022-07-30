Param(
    [string]$eventosenvolvidos,
    [string]$computadorafetado
)
#Hora e Dia em que o evento foi adicionado

$time = Get-Date -UFormat %H:%M:%S
$date = Get-Date -UFormat %d-%m-%y

#=========================================

#Verificando se o arquivo fonte já existe e adicionando os valores.

if ( {Test-Path $PSScriptRoot\QuerySource.csv} )
{
    foreach ($evento in $eventosenvolvidos)
    {
        Add-Content -Value "$computadorafetado,$date,$time,$evento" -Path $PSScriptRoot\QuerySource.csv
    }
}
else
{
    New-Item -ItemType File -Path $PSScriptRoot\QuerySource.csv
    Add-Content -Value "HostName,Data,Hora,Evento" -Path $PSScriptRoot\QuerySource.csv
    foreach ($evento in $eventosenvolvidos)
    {
        Add-Content -Value "$computadorafetado,$date,$time,$evento" -Path $PSScriptRoot\QuerySource.csv

    }
}

#===============================================

#verifica se é recorrente ou não

   Import-Csv -Path $PSScriptRoot\QuerySource.csv | Select-Object -Property HostName | foreach { if ($_ -like $computadorafetado) { $numRecorrencia = $numRecorrencia + 1 } }
   if ($numRecorrencia -gt 1)
   {
        .\DialogBox.exe -title "Armazenamento de Evidências SEP" -msg "Para o computador $computadorafetado Recorrências: $numRecorrencia" -warn
   }
   else
   {
        .\DialogBox.exe -title "Armazenamento de Evidências SEP" -msg "Sem recorrências para o micro "
   }

#===============================================
