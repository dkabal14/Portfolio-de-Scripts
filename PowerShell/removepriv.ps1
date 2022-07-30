import-module ActiveDirectory
#==============================================================================================

function Exibir-Creditos
{
    Write-Host "Escrito por Diego R. (diegos.sonda@contratada.oi.net.br) `nSuporte nível 3 RJ - Sonda IT" -ForegroundColor Cyan 
}

function Gera-Csv
{
    if ((Test-Path -Path "$PSScriptRoot\movOUv0.1.csv") -eq $true) #verifica se o csv existe
    {
        if (((Get-date)-(Get-ChildItem -Path "$PSScriptRoot\movOUv0.1.csv").CreationTime).TotalMinutes -gt 60) #verifica se foi criado há mais de 60 minutos
        {
            Remove-Item -Path "$PSScriptRoot\movOUv0.1.csv" -Force #delete o arquivo
            $arrTab = $null
            $arrTab = @()
            $excel = New-Object -ComObject "excel.application"
            $XlWorkBook = $excel.Workbooks.Open("$PSScriptRoot\movOUv0.1.xlsx")
            $XlWorkSheet = $XlWorkBook.Worksheets.Item(2)
            $XlWorkSheet.Columns | Where-Object {$_.column -eq 1} | foreach {$arrTab += $_.value2}
            $arrTab | Set-Content -Path "$PSScriptRoot\movOUv0.1.csv" #e crie um atualizado
            $result = Import-Csv -Path "$PSScriptRoot\movOUv0.1.csv" -Delimiter ";"
            $excel.Quit()
        }
        else #se não tem mais de 1 hora, apenas utilize o arquivo antigo
        {
            $result = Import-Csv -Path "$PSScriptRoot\movOUv0.1.csv" -Delimiter ";"
        }
    }
    else #se não existe arquivo csv, crie um novo atualizado
    {
        $arrTab = $null
        $arrTab = @()
        $excel = New-Object -ComObject "excel.application"
        $XlWorkBook = $excel.Workbooks.Open("$PSScriptRoot\movOUv0.1.xlsx")
        $XlWorkSheet = $XlWorkBook.Worksheets.Item(2)
        $XlWorkSheet.Columns | Where-Object {$_.column -eq 1} | foreach {$arrTab += $_.value2}
        $arrTab | Set-Content -Path "$PSScriptRoot\movOUv0.1.csv"
        $result = Import-Csv -Path "$PSScriptRoot\movOUv0.1.csv" -Delimiter ";"
        $excel.Quit()
    }
    return $result
}

function Objeto-mySQL
{
    $SQLServer = "servidor"
    $SQLDBName = "database"
    $uid ="usuario"
    $pwd = "senha"
    $SqlQuery = "SELECT * from table;"
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True; User ID = $uid; Password = $pwd;"
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.CommandText = $SqlQuery
    $SqlCmd.Connection = $SqlConnection
    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $SqlAdapter.SelectCommand = $SqlCmd
    $DataSet = New-Object System.Data.DataSet
    $SqlAdapter.Fill($DataSet)

    Return $DataSet.Tables[0]
}

function Main-Void
{
    Exibir-Creditos
    $OURoot = 'CN=Computers,DC=oi,DC=corp,DC=net'
    #$colComputadores = Get-ADComputer -Filter 'operatingsystem -like "*Windows*" -and operatingsystem -notlike "*Server*"' -SearchBase $OURoot | Select-Object -Property *
    $colComputadores = import-csv -path "D:\removepriv.csv"
    $tabOU = Gera-Csv
    #$Autenticacao = Get-Credential
    foreach ($objComputador in $colComputadores)
    {
        #========================
        #Remover depois
            $objComputador2 = Get-ADComputer -Identity $objComputador.Name | Select-Object -Property *
            $objDescricao = $objComputador.Descricao
        #Remover depois
        #========================
        
        #$nomeComputador = $objComputador.Name
        #$objOrigem = $objComputador.DistinguishedName #Seta a Origem
        
        #========================
        #Remover depois
            $nomeComputador = $objComputador2.Name
            $objOrigem = $objComputador2.DistinguishedName
        #Remover depois
        #========================

        #================================================================
        
        if ($nomeComputador.Length -ge 9) #Se o nome do computador for menor que 9 caracteres, impede que aconteça erro na função substring; Identifica o prefixo da etiqueta de TI
        {
            $prefixoHostName = $nomeComputador.Substring(0,9)
        }
        else
        {
            $prefixoHostName = $nomeComputador
        }

        #================================================================

        $objDestino = $tabOU | Where-Object {$_.hostname -eq $prefixoHostName} | Get-Unique | foreach {$_.ou} #Seta o destino

        #================================================================
        
        if ($objDestino -eq "Inexistente" -or $objDestino -eq $null) #Se o destino não existir na planilha (ou banco de dados), coloca o equipamento em Regional RJ
        
        {
            $objDestino = "OU=Regional RJ,OU=Estacoes,DC=oi,DC=corp,DC=net" # caminho para as exceções
        }

        
        "======================================"
        "Nome do computador: " + $nomeComputador
        "Caminho de Origem:  " + $objOrigem
        "Caminho de Destino: " + $objDestino
        "Descrição do Move:  " + $objDescricao

        
        Try
        {
            Set-ADComputer -Identity $objOrigem -Description $objDescricao
            Move-ADObject -Identity $objOrigem -TargetPath $objDestino #-WhatIf #-Credential $Autenticacao
            Write-Host "Equipamento $nomeComputador sendo movido para a OU: `n$objDestino" -ForegroundColor Green
            (Get-Date -Format g) + " - Equipamento " + $nomeComputador + " sendo movido para a OU: " + $objDestino | Out-File -FilePath "$PSScriptRoot\movOUv0.1.log" -Append
        }
        Catch
        {
            Write-Host "Não foi possível mover o computador $nomeComputador para a OU: `n$objDestino" -ForegroundColor Red
            (Get-Date -Format g) + " - Não foi possível mover o computador " + $nomeComputador + " para a OU: `n" + $objDestino | Out-File -FilePath "$PSScriptRoot\movOUv0.1.log" -Append
        }
        
        "======================================"
    }
}

#Rotina Principal
Main-Void