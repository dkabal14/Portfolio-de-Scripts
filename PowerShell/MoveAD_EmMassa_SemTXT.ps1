<#Script desenvolvido por Diego Ros�rio Sousa - Sonda - Suporte N�vel 3 - RJ
diegos.sonda@contratada.oi.net.br


OU de Destino deve estar entre aspas
Caso n�o saiba dizer, pesquise a OU de destino no powershell com o texto abaixo, trocando OUPesquisada pelo nome da OU 


#Get-ADOrganizationalUnit -filter {Name -eq "*OuPesquisada*"} | Select-Property -Property distinguishedName
#>

#=================================== OU DE DESTINO =============================================
#OU Padrão Desktops RJ
#OU=Homolog_proxy,OU=Restricted_Groups_Homolog,OU=FW_Desktops,OU=Desktops,OU=Filial,OU=Oi,OU=Regional RJ,OU=Estacoes,DC=oi,DC=corp,DC=net
$OUDestino = "OU=Homolog_Proxy,OU=Restricted_Groups_Homolog,OU=FW_Notebooks,OU=Notebooks,OU=Filial,OU=Oi,OU=Regional RJ,OU=Estacoes,DC=oi,DC=corp,DC=net"

<# PARA ESPELHAMENTO DE OU, COLOCAR A M�QUINA DE REFER�NCIA 3 #>
<#
    $espelho = "DSKCCTRMS090302"
    $ComputerObject = get-adcomputer -Filter {Name -eq $espelho} | ForEach-Object {$_.distinguishedName}
    $OU = $ComputerObject.Split(",")
    $i = 0
    do
    {
        if ($i -eq 0)
        {
            $i = $i + 1
        }
        $NovaOU = $NovaOU + $OU[$i] + ","
        $i = $i + 1
    }
    Until ($i -eq $OU.Count)
    $OUDestino = $NovaOU.Substring(0,($NovaOU.length - 1))
    $NovaOU = $null
#>

#=================================== OU DE DESTINO =============================================



#Coloque a lista de m�quinas abaixo:
#==================================== LISTA DE M�QUINAS ========================================
$lista = "

"

#==================================== LISTA DE M�QUINAS ========================================

#Apenas para compara��o e elimina��o de linhas vazias


$lista = $lista.Replace("`r","/").Replace("`n","\")
$lista = $lista.Substring(2,$lista.Length - 4).Split("/\")

$hostnames = $lista

foreach ($hostname in $hostnames)
{
        
        try
        {
            $nHostname = $hostname
            $OUOrigem = get-adcomputer -filter {name -eq $nHostname} | ForEach-Object {$_.distinguishedName}
            Write-Host "Objeto $nHostname" -ForegroundColor Cyan
            #Move-ADObject -Identity $OUOrigem -TargetPath $OUDestino
            Write-Host " OU de Origem: $OUOrigem`n OU de Destino: $OUDestino" -ForegroundColor Green
        }
        catch
        {
            Write-Host "Objeto $nHostname" -ForegroundColor Cyan
            Write-Host " OU de Origem: $OUOrigem`n OU de Destino: $OUDestino`n OPERA��O FALHOU!" -ForegroundColor Red
        }
}