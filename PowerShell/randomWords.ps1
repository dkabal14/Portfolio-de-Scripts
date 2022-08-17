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
    if ($TextoBase -eq $null)
    {
        $TextoBase = input-grafico -Texto "Digite o texto base abaixo:"
    }
    if ($NumPalavras -eq $null)
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

randomWords -Numpalavras 100 -TextoBase "A bolinha nasceu de um pato arriscado e monolitico que conseguia voar sobre aguas distantes toda noite"