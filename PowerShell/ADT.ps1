#Escrito por Diego Rosário Sousa
#diegorosariosousa@gmail.com
#Script que gera um log dos textos que foram salvos na área de transferência (Ctrl+C)

#Cria o objeto do Shell para abrir as caixas de texto
$WShell = New-Object -ComObject Wscript.Shell
#Adiciona o Assembly do FORMS 
Add-Type -AssemblyName system.windows.forms

#Criando o arquivo de log
$numAleatorio = Get-Random -Maximum 99999
$dataAtual = Get-Date -UFormat %d-%m-%y
$tempoAtual = Get-Date -UFormat %H:%M:%S
$nomeDoArquivo = $dataAtual + '_' + $numAleatorio + '.log'
New-Item -ItemType File -Path $PSScriptRoot\$nomeDoArquivo
if ({ Test-Path $PSScriptRoot\$nomeDoArquivo })
{
    $WShell.Popup("Salvando o log no arquivo: $nomeDoArquivo", 0, "ADT", 0 + 64 + 256)
}
else
{
    $WShell.Popup("O arquivo $nomeDoArquivo não pôde ser criado", 0, "ADT", 0 + 48)
}

#Salvando o clipboard
$strADTAntiga = "hsdjkhkgrhisdorghiosdugh111(*&¨(*@@@)(#"
$varLoop = "nunca sair"
Do
{
    if ( [windows.forms.clipboard]::ContainsText() )
    {
        $strADT = [windows.forms.clipboard]::GetText()
        if ( [string]::IsNullOrWhiteSpace($strADT) )
        {
            Start-Sleep -Seconds 1
        }
        else
        {
            if ($strADT -eq $strADTAntiga)
            {
                Start-Sleep -Seconds 1
            }
            else
            {
                $strADTAntiga = $strADT
                $strADT | Add-Content $PSScriptRoot\$nomeDoArquivo
                Write-Host '=================' $dataAtual '-' $tempoAtual '=================' `n `n $strADT
            }
        }
    }
    else
    {
        Start-Sleep -Seconds 1
    }
} while ($varLoop -eq "nunca sair")