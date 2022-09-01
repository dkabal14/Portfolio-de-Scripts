
Set WshShell = WScript.CreateObject("WScript.Shell")
SysName = WshShell.ExpandEnvironmentStrings("%COMPUTERNAME%")
 
'### Pergunta o nome do servi�o a ser Habilitado/Inicializado.
strSvcname = "RemoteRegistry"

'### Pergunta o nome do servi�o a ser Parado/Inicializado.
strSvcname1 = "lanmanserver"

'### Pergunta o valor a ser configurado para a chave de registro.
strKeyValue = "1"
 
'### Monta lista com as m�quinas a serem atingidas.
Dim srcFile
srcFile = "host.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objTextFile = objFSO.OpenTextFile(srcFile, 1)

'### Gera arquivo de log
Dim logFile
Const forAppending = 8
logFile = "pe-h_resul.txt"
Set oFsOutput = CreateObject("scripting.filesystemobject")
Set oTextOutput = oFsOutput.OpenTextFile(logFile,forAppending,True)
oTextOutput.WriteLine ("Hostname; Servi�o " & strSvcname & ";Obs;" & "Servi�o " & strSvcname & ";Obs;" & "Servi�o " & strSvcname & ";Obs;" & "Servi�o " & strSvcname & ";Obs;")

'---------------------- Habilita e Inicializa o servi�o -----------------------'

'### Inicia processo nas m�quinas
Do Until objTextFile.AtEndOfStream
Dim ObjComputer
intSize = 0
ObjComputer = objTextFile.ReadLine
strComputer = ObjComputer   

Err.Number = 0

On Error Resume Next

   '### Usa WMI para conectar ao computador.
   Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _
      strComputer & "\root\cimv2")
 
   ServiceStop("Browser")
 
  '### Tenta Habilitar o servi�o.
  ServiceEna(strSvcname)
 
  '### Traduz o c�digo de erro.
   If Err.Number = 0 Then
      oTextOutput.Write (strComputer & ";" & "Habilitado;" & Err.Description & ";")
   Else
      oTextOutput.Write (strComputer & ";" & "Falha ao Habilitar;" & Err.Description & ";")
   End If
 
'### Se Habilitado com sucesso, Inicializa o servi�o.
   If Err.Number = 0 Then
  	 ServiceStart(strSvcname)
 
   	 '### Traduz o c�digo de erro.
   	 If Err.Number = 0 Then
           oTextOutput.Write ("Inicializado;" & Err.Description & ";")
         Else
           oTextOutput.Write ("Falha ao inicializar;" & Err.Description & ";")
       End If     
   
   End If

'---------------------- Muda a chave de registro ------------------------------'

'### Muda a chave de registro para o valor definido
errRtnChangeKey = ChangeKey(strKeyValue)

'---------------------- Para/Incializa o servi�o ------------------------------'

'### Para o servi�o Especificado em strSvcname1

ServiceStop(strSvcname1)
 
'### Translate return code.
If Err.Number = 0 Then
  oTextOutput.Write ("Parado;" & Err.Description & ";")
  Else
    oTextOutput.Write ("Falha ao parar;" & Err.Description & ";")
End If     

If Err.Number = 0 Then
  '### Inicializa o servi�o Especificado em strSvcname1
  ServiceStart(strSvcname1)

  '### Traduz o c�digo de erro.
   If Err.Number = 0 Then
     oTextOutput.Write ("Inicializado;" & Err.Description & ";")
     Else
       oTextOutput.Write ("Falha ao inicializar;" & Err.Description & ";")
   End If  

End If	

ServiceStart("Browser")
oTextOutput.WriteLine

'--------------------------------- Fim ----------------------------------------'

'### Vai para a pr�xima m�quina na lista.
Loop

 
'### Informa ao Usu�rio.
WScript.Echo "Opera��o Completa"

'################################################################################
'# ServiceStart
'# Proposito: Inicializar um servi�o.
'#
'# Entrada: Nome - nome do servi�o, n�o o display name.
'# Retorna: Retorna um inteiro atrav�s da chamada WMI para inicializar o servi�o.
'#
'################################################################################
Function ServiceStart(strServiceName)
   Set colServices = objWMIService.ExecQuery _
      ("SELECT * FROM win32_Service WHERE Name = '" & strServiceName & "'")
 
   '### Garante que o servi�o exite, ent�o inicializa o mesmo.
   If colServices.Count > 0 Then
      For Each objService in colServices
         errCode = objService.StartService()
         '### Captura o retorno gerado
         ServiceStart = err.Number
      Next
 
   '### Se o servi�o n�o existir, Especifica o erro n�mero 99.
   Else
      ServiceStart = 99
   End If
 
   '#### Realiza uma pausa para recria��o das refer�ncias.
   Set colServices = Nothing
   WScript.Sleep 250
 
'Final ServiceStart
End Function

'################################################################################
'# ServiceStop
'# Proposito: Paralizar um servi�o.
'#
'# Entrada: Nome - nome do servi�o, n�o o display name.
'# Retorna: Retorna um inteiro atrav�s da chamada WMI para paralizar o servi�o.
'#
'################################################################################
Function ServiceStop(strServiceName)
   Set colServices = objWMIService.ExecQuery _
      ("SELECT * FROM win32_Service WHERE Name = '" & strServiceName & "'")
 
   '### Garante que o servi�o exite, ent�o para o mesmo.
   If colServices.Count > 0 Then
      For Each objService in colServices
         errCode = objService.StopService()
         '### Captura o retorno gerado
         ServiceStop = err.Number
      Next
 
   '### Se o servi�o n�o existir, Especifica o erro n�mero 99.
   Else
      ServiceStop = 99
   End If
 
   '#### Realiza uma pausa para recria��o das refer�ncias.
   Set colServices = Nothing
   WScript.Sleep 250
 
'Final ServiceStop
End Function

'################################################################################
'# ServiceEna
'# Proposito: Habilitar um servi�o.
'#
'# Entrada: Nome - nome do servi�o, n�o o display name.
'# Retorna: Retorna um inteiro atrav�s da chamada WMI para habilitar o servi�o.
'#
'################################################################################
Function ServiceEna(strServiceName)
   Set colServices = objWMIService.ExecQuery _
      ("SELECT * FROM win32_Service WHERE Name = '" & strServiceName & "'")
   For Each objService in colServices
 
      '### Se n�o estiver Habilitado, Habilita o servi�o e captura o retorno.
      If objService.StartMode <> "Automatic" Then
         errCode = objService.Change( , , , , "Automatic")
      End If
   Next

   '#### Realiza uma pausa para recria��o das refer�ncias.
   Set colServices = Nothing
   WScript.Sleep 250
 
'### Final ServiceEna
End Function

'################################################################################
'# ServiceDis
'# Proposito: Desabilitar um servi�o.
'#
'# Entrada: Nome - nome do servi�o, n�o o display name.
'# Retorna: Retorna um inteiro atrav�s da chamada WMI para desabilitar o servi�o.
'#
'################################################################################
Function ServiceDis(strServiceName)
   Set colServices = objWMIService.ExecQuery _
      ("SELECT * FROM win32_Service WHERE Name = '" & strServiceName & "'")
   For Each objService in colServices
 
      '### Se n�o estiver Desabilitado, Desabilita o servi�o e captura o retorno.
      If objService.StartMode <> "Disabled" Then
         errCode = objService.Change( , , , , "Disabled")
      End If
   Next

   '#### Realiza uma pausa para recria��o das refer�ncias.
   Set colServices = Nothing
   WScript.Sleep 250
 
'### Final ServiceDis
End Function

'################################################################################
'# ChangeKey
'# Proposito: Mudar chave de registro.
'#
'# Entrada: Valor a ser configurado para a chave
'# Retorna: Retorna um inteiro atrav�s da chamada o.Reg para mudar o registro.
'#
'################################################################################
Function ChangeKey(strKeyValue)

	Const HKEY_LOCAL_MACHINE = &H80000002

	Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ 
    	strComputer & "\root\default:StdRegProv")
 
	strKeyPath = "SYSTEM\CurrentControlSet\Services\lanmanserver\parameters"
	strValueName = "autosharewks"
	dwValue = strKeyValue
	oReg.SetDWORDValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,dwValue

'### Final ChangeKey
End Function

'################################################################################
'# ErrCodeNarr
'# Purpose: Traduz o erro gerado.
'#
'# Input: Inteiro retornado por uma chamada WMI para modificar um servi�o.
'# Returns: Texto com explica��o do erro gerado.
'#
'################################################################################
Function ErrCodeNarr(intCodeNr)
 
   '### Inicializa o retorno.
   ErrCodeNarr = ""

   Select Case intCodeNr
      '### Acesso Negado.
      Case 2
         ErrCodeNarr = "Accesso Negado."
      Case 3
         ErrCodeNarr = "Servi�os Dependentes est�o sendo executados."
      Case 5
         ErrCodeNarr = "Servi�o n�o aceita o controle."
      Case 6
         ErrCodeNarr = "Servi�o n�o est� ativo."
      Case 8
         ErrCodeNarr = "Falha desconhecida."
      Case 10
         '### strErrMsg WOULD be "Service Already Stopped."
         '### For this - NOT an error.
      Case 11
         ErrCodeNarr = "Base de dados do servi�o bloqueada (locked)."
      Case 14
         '### strErrMsg WOULD be "Service already Disabled."
         '### For this - NOT an error.
      Case 16
         '### strErrMsg WOULD be Service Marked For Deletion."
         '### For this - NOT an error.
      Case 99
         ErrCodeNarr = "Servi�o n�o existe."
      Case Else
         '### Other conditions unlike to exist or not a problem.
   End Select
 
'### End ErrCodeNarr
End Function