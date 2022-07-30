<#
  Script escrito por Diego Rosário Sousa - diegorosariosousa@gmail.com
  Faz uma consulta de um arquivo de excel como se esse fosse uma database conectada ao ODBC
  Veja a referência e pré-requisito em: https://web.synametrics.com/queryexcel.htm
#>

$arquivo = "D:\odbc.xlsx"
$Tabela = "Plan1"
$conexão = New-Object System.Data.OleDb.OleDbConnection
$stringDeConexão = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=$arquivo;Extended Properties='Excel 12.0 Xml;HDR=YES;'"
$conexão.ConnectionString = $stringDeConexão
$conexão.Open()
#------------------------------
$OLEDBcomando = New-Object System.Data.OleDb.OleDbCommand
$OLEDBcomando.CommandText = "SELECT * FROM ["+$Tabela+"$]"
#$OLEDBcomando.CommandText = "INSERT INTO [$Tabela$] VALUES ('5','nunes')"
$OLEDBcomando.CommandType = "Text"
$OLEDBcomando.Connection = $conexão

$dataReader = $OLEDBcomando.ExecuteReader()
#------------------------------
While ($dataReader.Read()) {
  Write-Host $datareader.item("id") $datareader.Item("nome") $datareader.
}
#$OLEDBcomando.ExecuteNonQuery()
#PARA QUALQUER COMANDO QUE NÃO SEJA SELECT. USAR $OLEDBcomando.ExecuteNonQuery()
#------------------------------


$OLEDBcomando.Dispose()
$conexão.Close()

