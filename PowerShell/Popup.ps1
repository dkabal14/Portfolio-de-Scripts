#Método de uso do objeto Wscript.Shell.Popup

#Cria o objeto no Shell
$WShell = New-Object -ComObject Wscript.Shell

#Usa o parâmetro .popup para abrir uma caixa de diálogo
#Sintaxe: $WShell.Popup("<Texto exibido>", <tempo de espera para a caixa abrir>, "<Título da Caixa>", <Opções de botões> + <alertas>)

<#
    <Opções de Botões>
    0 (default)
    Exibe: OK
    Responde: 1

    1
    Exibe: OK e Cancelar
    Responde: 1 e 2

    2
    Exibe: Anular, Repetir e Ignorar
    Responde: 3, 4 e 5

    3
    Exibe: Sim, Não e Cancelar
    Responde:6, 7 e 2

    4
    Exibe: Sim e Não
    Responde: 6 e 7

    5
    Exibe: Repetir e Cancelar
    Responde: 4 e 2
#>

<#
    <alertas> (não é exibido por padrão)
    16
    Exibe Ícone de erro

    32
    Exibe ícone de pergunta

    48
    Exibe ícone de aviso

    64
    Exibe ícone de informação
#>
function Popup {
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
Popup -Mensagem "linha 1`nlinha 2" -tempo 0 -botao "OKCancelar" -titulo "Meu Título" -Icone "Informacao"