. $PSScriptRoot\Functions.ps1

function randomWords()
{
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        $NumPalavras,
        [Parameter()]
        [string]
        $TextoBase
    )
    if ($null -eq $TextoBase)
    {
        $TextoBase = input-grafico -Texto "Digite o texto base abaixo:"
    }
    if ($null -eq $NumPalavras)
    {
        $numPalavras = input-grafico -Texto "Digite o número de palavras abaixo:"
    }
    $rTxt = $TextoBase.Split(" ")
    $rnge = 0..$numPalavras
    foreach ($item in $rnge)
    {
        $Texto = $Texto + " " + $rTxt[(get-random -Minimum 0 -Maximum $rTxt.Length)]
    }
    return $Texto
}

randomWords -Numpalavras 10000 -TextoBase "Bem-Vindo(a) à documentação técnica da Plataforma de Dados! Aqui você encontrará as informações necessárias para realizar integrações com as APIs de dados e consumir os datasets que deseja. Caso ainda não tenha lido nosso Guia Geral, ou não esteja familiarizado com alguns dos termos usados na documentação técnica, recomendamos fortemente que leia-o antes de seguir."