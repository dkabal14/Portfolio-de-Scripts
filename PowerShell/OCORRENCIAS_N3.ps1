Function Perguntar-Usuario
{
    $titulo = "Ocorrências N3"
    $mensagem = "Deseja consultar ou anotar?"
    $consultar = New-Object System.Management.Automation.Host.ChoiceDescription "&Consultar", "Consulta o arquivo CSV por anotações de hoje"
    $anotar = New-Object System.Management.Automation.Host.ChoiceDescription "&Anotar", "Inicia o formulário de anotação"
    $opcoes = [System.Management.Automation.Host.ChoiceDescription[]]($consultar, $anotar)
    $resultado = $Host.UI.PromptForChoice($titulo, $mensagem, $opcoes, 0)
    return $resultado
}

function ConverteData-ParaEUA
{
    param 
    (
        [datetime] $data
    )
    return 
}

Function Anotar-Ocorrencia
{
    $caminhoArquivo = "D:\OCORRENCIAS_N3.CSV"
    $numeroARS = Read-Host -Prompt "Digite o número do ARS"
    $dataOcorrencia = Read-Host -Prompt "Digite a data da ocorrência"
    $nomeTecnico = Read-Host -Prompt "Digite o nome do solicitante"
    $Abertura = Read-Host -Prompt "Digite a descrição de abertura"
    $EventoSEP = Read-Host -Prompt "Digite o nome do relatório do SEP"
    $Horario = Read-Host -Prompt "Digite o horário do relatório"
    Add-Content $caminhoArquivo "`n"
    Add-Content $caminhoArquivo "$numeroARS,$dataOcorrencia,$nomeTecnico,$EventoSEP,$Horario,$Abertura"
}

$fileExists = Test-Path D:\OCORRENCIAS_N3.CSV
if ($fileExists -eq $True)
{
    $primeiLinha = Get-Content D:\OCORRENCIAS_N3.CSV -head 1
    if ($primeiLinha -eq "ARS,DATA,SOLICITANTE,EVENTO,HORARIO,DESCRICAO")
    {
        $i = "não"
        while ($i -eq "não")
        {
            switch (Perguntar-Usuario)
            {
                0 #consultar
                {
                    Clear-Host
                    Import-Csv D:\OCORRENCIAS_N3.CSV
                    Pause
                }
                1 #anotar
                {
                    Clear-Host
                    Anotar-Ocorrencia
                }
            }
        }
    }
    else
    {
        
    }
}