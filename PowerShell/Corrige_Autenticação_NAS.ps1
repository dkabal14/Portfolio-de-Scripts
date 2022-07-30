#Script desenvolvido por Diego Rosário Sousa
#diegorosariosousa@gmail.com

#Corrige erro de conta no acesso a diretórios de rede

#verifica se a chave MrxSmb10
$smb1 = test-path("HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10")

#verifica se a chave MrxSmb20
$smb2 = test-path("HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb20")

$servico = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation"
function Cria-Arquivo
{
    $Pasta = "C:\Windows\CCM"
    $Arquivo = "CorrecaoNAS.txt"
    New-Item -Path $Pasta -Name $Arquivo -ItemType File -Force
}

#Verifica os valores atuais da chave DependOnService
$antigo = Get-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\LanmanWorkstation" -Name "DependOnService" | ForEach-Object {$_.DependOnService}

if ($smb1 -eq $true -and $smb2 -eq $true) #se existirem as chaves do smb1 e smb2
{
    $novo = @('Bowser', 'MRxSmb10', 'MRxSmb20', 'NSI')
    $compare = Compare-Object -ReferenceObject $novo -DifferenceObject $antigo
    if ($null -ne $compare.InputObject)
    {
        New-ItemProperty -Path $servico -Name 'DependOnService' -PropertyType MultiString -Value $novo -Force
        Write-Host "Adicionado o valor $compare.InputObject"
        Cria-Arquivo
    }
    else
    {
        Write-Host "Valores da chave já estão corretos"
        Cria-Arquivo
    }
}
elseif ($smb1 -eq $true -and $smb2 -eq $false) #se existir somente a chave smb1
{
    $novo = @('Bowser', 'MRxSmb10', 'NSI')
    $compare = Compare-Object -ReferenceObject $novo -DifferenceObject $antigo
    if ($null -ne $compare.InputObject)
    {
        New-ItemProperty -Path $servico -Name 'DependOnService' -PropertyType MultiString -Value $novo -Force
        Write-Host "Adicionado o valor $compare.InputObject"
        Cria-Arquivo
    }
    else
    {
        Write-Host "Valores da chave já estão corretos"
        Cria-Arquivo
    }
}
elseif ($smb1 -eq $false -and $smb2 -eq $true) #se existir somente a chave smb2
{
    $novo = @('Bowser', 'MRxSmb20', 'NSI')
    $compare = Compare-Object -ReferenceObject $novo -DifferenceObject $antigo
    if ($null -ne $compare.InputObject)
    {
        New-ItemProperty -Path $servico -Name 'DependOnService' -PropertyType MultiString -Value $novo -Force
        Write-Host "Adicionado o valor $compare.InputObject"
        Cria-Arquivo
    }
    else
    {
        Write-Host "Valores da chave já estão corretos"
        Cria-Arquivo
    }
}
