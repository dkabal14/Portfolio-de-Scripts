function Get-ODBC-Data{
    param(
    [string]$query=$(throw 'query is required.'),
    [string]$dsn
    )
    $conn = New-Object System.Data.Odbc.OdbcConnection
    $conn.ConnectionString = "DSN=$dsn;"
    $conn.open()
    $cmd = New-object System.Data.Odbc.OdbcCommand($query,$conn)
    $ds = New-Object system.Data.DataSet
    (New-Object system.Data.odbc.odbcDataAdapter($cmd)).fill($ds) | out-null
    $conn.close()
    $ds.Tables[0]
 }
 Get-ODBC-Data -query "SELECT Numero-do-ARS, Status FROM TELEM:AberturaDeOS WHERE (Agente-de-Solucao-2 = 'OPERACAO_ONSITE_RJ') AND (Status < '7')" -dsn "DSN=remedy_arsweb;ARServer=ASERELAPP;ARServerPort=3111;UID=T71284R;ARAuthentication=;ARNameReplace=1;SERVER=NotTheServer"