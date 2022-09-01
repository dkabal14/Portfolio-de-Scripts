
Set WshShell = WScript.CreateObject("WScript.Shell")
SysName = WshShell.ExpandEnvironmentStrings("%COMPUTERNAME%")
 
'### Pergunta o nome do serviço a ser Habilitado/Inicializado.
strSvcname = "RemoteRegistry"

'### Pergunta o nome do serviço a ser Parado/Inicializado.
strSvcname1 = "lanmanserver"

'### Pergunta o valor a ser configurado para a chave de registro.
strKeyValue = "1"
 
'### Monta lista com as máquinas a serem atingidas.
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
oTextOutput.WriteLine ("Hostname; Serviço " & strSvcname & ";Obs;" & "Serviço " & strSvcname & ";Obs;" & "Serviço " & strSvcname & ";Obs;" & "Serviço " & strSvcname & ";Obs;")

'---------------------- Habilita e Inicializa o serviço -----------------------'

'### Inicia processo nas máquinas
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
 
  '### Tenta Habilitar o serviço.
  ServiceEna(strSvcname)
 
  '### Traduz o código de erro.
   If Err.Number = 0 Then
      oTextOutput.Write (strComputer & ";" & "Habilitado;" & Err.Description & ";")
   Else
      oTextOutput.Write (strComputer & ";" & "Falha ao Habilitar;" & Err.Description & ";")
   End If
 
'### Se Habilitado com sucesso, Inicializa o serviço.
   If Err.Number = 0 Then
  	 ServiceStart(strSvcname)
 
   	 '### Traduz o código de erro.
   	 If Err.Number = 0 Then
           oTextOutput.Write ("Inicializado;" & Err.Description & ";")
         Else
           oTextOutput.Write ("Falha ao inicializar;" & Err.Description & ";")
       End If     
   
   End If

'---------------------- Muda a chave de registro ------------------------------'

'### Muda a chave de registro para o valor definido
errRtnChangeKey = ChangeKey(strKeyValue)

'---------------------- Para/Incializa o serviço ------------------------------'

'### Para o serviço Especificado em strSvcname1

ServiceStop(strSvcname1)
 
'### Translate return code.
If Err.Number = 0 Then
  oTextOutput.Write ("Parado;" & Err.Description & ";")
  Else
    oTextOutput.Write ("Falha ao parar;" & Err.Description & ";")
End If     

If Err.Number = 0 Then
  '### Inicializa o serviço Especificado em strSvcname1
  ServiceStart(strSvcname1)

  '### Traduz o código de erro.
   If Err.Number = 0 Then
     oTextOutput.Write ("Inicializado;" & Err.Description & ";")
     Else
       oTextOutput.Write ("Falha ao inicializar;" & Err.Description & ";")
   End If  

End If	

ServiceStart("Browser")
oTextOutput.WriteLine

'--------------------------------- Fim ----------------------------------------'

'### Vai para a próxima máquina na lista.
Loop

 
'### Informa ao Usuário.
WScript.Echo "Operação Completa"

'################################################################################
'# ServiceStart
'# Proposito: Inicializar um serviço.
'#
'# Entrada: Nome - nome do serviço, não o display name.
'# Retorna: Retorna um inteiro através da chamada WMI para inicializar o serviço.
'#
'################################################################################
Function ServiceStart(strServiceName)
   Set colServices = objWMIService.ExecQuery _
      ("SELECT * FROM win32_Service WHERE Name = '" & strServiceName & "'")
 
   '### Garante que o serviço exite, então inicializa o mesmo.
   If colServices.Count > 0 Then
      For Each objService in colServices
         errCode = objService.StartService()
         '### Captura o retorno gerado
         ServiceStart = err.Number
      Next
 
   '### Se o serviço não existir, Especifica o erro número 99.
   Else
      ServiceStart = 99
   End If
 
   '#### Realiza uma pausa para recriação das referências.
   Set colServices = Nothing
   WScript.Sleep 250
 
'Final ServiceStart
End Function

'################################################################################
'# ServiceStop
'# Proposito: Paralizar um serviço.
'#
'# Entrada: Nome - nome do serviço, não o display name.
'# Retorna: Retorna um inteiro através da chamada WMI para paralizar o serviço.
'#
'################################################################################
Function ServiceStop(strServiceName)
   Set colServices = objWMIService.ExecQuery _
      ("SELECT * FROM win32_Service WHERE Name = '" & strServiceName & "'")
 
   '### Garante que o serviço exite, então para o mesmo.
   If colServices.Count > 0 Then
      For Each objService in colServices
         errCode = objService.StopService()
         '### Captura o retorno gerado
         ServiceStop = err.Number
      Next
 
   '### Se o serviço não existir, Especifica o erro número 99.
   Else
      ServiceStop = 99
   End If
 
   '#### Realiza uma pausa para recriação das referências.
   Set colServices = Nothing
   WScript.Sleep 250
 
'Final ServiceStop
End Function

'################################################################################
'# ServiceEna
'# Proposito: Habilitar um serviço.
'#
'# Entrada: Nome - nome do serviço, não o display name.
'# Retorna: Retorna um inteiro através da chamada WMI para habilitar o serviço.
'#
'################################################################################
Function ServiceEna(strServiceName)
   Set colServices = objWMIService.ExecQuery _
      ("SELECT * FROM win32_Service WHERE Name = '" & strServiceName & "'")
   For Each objService in colServices
 
      '### Se não estiver Habilitado, Habilita o serviço e captura o retorno.
      If objService.StartMode <> "Automatic" Then
         errCode = objService.Change( , , , , "Automatic")
      End If
   Next

   '#### Realiza uma pausa para recriação das referências.
   Set colServices = Nothing
   WScript.Sleep 250
 
'### Final ServiceEna
End Function

'################################################################################
'# ServiceDis
'# Proposito: Desabilitar um serviço.
'#
'# Entrada: Nome - nome do serviço, não o display name.
'# Retorna: Retorna um inteiro através da chamada WMI para desabilitar o serviço.
'#
'################################################################################
Function ServiceDis(strServiceName)
   Set colServices = objWMIService.ExecQuery _
      ("SELECT * FROM win32_Service WHERE Name = '" & strServiceName & "'")
   For Each objService in colServices
 
      '### Se não estiver Desabilitado, Desabilita o serviço e captura o retorno.
      If objService.StartMode <> "Disabled" Then
         errCode = objService.Change( , , , , "Disabled")
      End If
   Next

   '#### Realiza uma pausa para recriação das referências.
   Set colServices = Nothing
   WScript.Sleep 250
 
'### Final ServiceDis
End Function

'################################################################################
'# ChangeKey
'# Proposito: Mudar chave de registro.
'#
'# Entrada: Valor a ser configurado para a chave
'# Retorna: Retorna um inteiro através da chamada o.Reg para mudar o registro.
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
'# Input: Inteiro retornado por uma chamada WMI para modificar um serviço.
'# Returns: Texto com explicação do erro gerado.
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
         ErrCodeNarr = "Serviços Dependentes estão sendo executados."
      Case 5
         ErrCodeNarr = "Serviço não aceita o controle."
      Case 6
         ErrCodeNarr = "Serviço não está ativo."
      Case 8
         ErrCodeNarr = "Falha desconhecida."
      Case 10
         '### strErrMsg WOULD be "Service Already Stopped."
         '### For this - NOT an error.
      Case 11
         ErrCodeNarr = "Base de dados do serviço bloqueada (locked)."
      Case 14
         '### strErrMsg WOULD be "Service already Disabled."
         '### For this - NOT an error.
      Case 16
         '### strErrMsg WOULD be Service Marked For Deletion."
         '### For this - NOT an error.
      Case 99
         ErrCodeNarr = "Serviço não existe."
      Case Else
         '### Other conditions unlike to exist or not a problem.
   End Select
 
'### End ErrCodeNarr
End Function