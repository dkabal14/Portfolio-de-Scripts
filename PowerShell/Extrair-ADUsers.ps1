#Script escrito por Diego Rosário Sousa - diegorosariosousa@gmail.com
#Faz a extração de usuários ativos no Active Directory
$nomeDestino = "ExtracaoAD_" + (Get-Date -Format dd-MM-yyyy)
$pastaDestino = "$env:USERPROFILE\Documents\"
$extensaoArquivo = ".csv"
$arquivoDestino =  $pastaDestino + $nomeDestino + $extensaoArquivo
#$arquivoDestino =  $pastaDestino + $nomeDestino + $extensaoArquivo
function Popup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $Mensagem,

        [Parameter(Mandatory=$false)]
        [int32]
        $tempo = 0,

        [Parameter(Mandatory=$false)]
        [validateset("OK","OKCancelar","AnularRepetirIgnorar","SimNaoCancelar","SimNao","RepetirCancelar")]
        $Botao = "OK",

        [Parameter(Mandatory=$false)]
        [string]
        $titulo = "Sem título",

        [Parameter(Mandatory=$false)]
        [string]
        [validateset("Erro","Questionamento","Aviso","Informacao")]
        $Icone = "Informacao"
    )
    $WShell = New-Object -ComObject Wscript.Shell
    switch ($Botao) 
    {
        
        "OK"
        {
            $buttChoice = 0
        }
        "OKCancelar"
        {
            $buttChoice = 1
        }
        "AnularRepetirIgnorar"
        {
            $buttChoice = 2
        }
        "SimNaoCancelar"
        {
            $buttChoice = 3
        }
        "SimNao"
        {
            $buttChoice = 4
        }
        "RepetirCancelar"
        {
            $buttChoice = 5
        }
    }

    switch ($Icone)
    {
        "Erro"
        {
            $IconChoice = 16
        }
        "Questionamento"
        {
            $IconChoice = 32
        }
        "Aviso"
        {
            $IconChoice = 48
        }
        "Informacao"
        {
            $IconChoice = 64
        }
    }


    $Choice = $WShell.Popup($Mensagem, $tempo, $titulo, $buttChoice + $IconChoice)
    switch ($Choice) {
        1 {$Return = "OK"}
        2 {$Return = "Cancelar"}
        3 {$Return = "Anular"}
        4 {$Return = "Repetir"}
        5 {$Return = "Ignorar"}
        6 {$Return = "Sim"}
        7 {$Return = "Nao"}
    }
    $Return
}
Write-Host "INICIANDO A EXTRACAO DO AD!" -ForegroundColor Green
get-aduser -filter {Enabled -eq $true} `
-Properties Name,DisplayName,EmailAddress,extensionAttribute4,MobilePhone,telephoneNumber | `
    Select-Object -Property `
        @{
            Label='Id'
            Expression={
                ($_.Name)
            }
        },
        @{
            Label='Nome Completo'
            Expression={
                ($_.DisplayName)
            }
        },
        @{
            Label='E-mail'
            Expression={
                ($_.EmailAddress)
            }
        },
        @{
            Label='Login do ARS'
            Expression={
                ($_.extensionAttribute4)
            }
        },
        @{
            Label='Tel Movel'
            Expression={
                ($_.MobilePhone)
            }
        },
        @{
            Label='Tel Fixo'
            Expression={
                ($_.telephoneNumber)
            }
        } | `
        #ConvertTo-Json | Add-Content -Path $arquivoDestino
        Export-Csv -Path $arquivoDestino

Popup -Mensagem "Processo terminado!" -titulo $nomeDestino -Icone "Informacao"
