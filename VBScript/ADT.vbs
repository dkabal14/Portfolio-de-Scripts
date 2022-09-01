'Escrito por Diego Rosário Sousa
'E-mail: diegorosariosousa@gmail.com
'Control+C Logger

'Option Explicit
On Error Resume Next

Dim objFSO 'Guarda o objeto do FileSystem.Object
Dim objTexto 'Guarda o método "CreateTextFile" de FileSystem.Object
Dim varLoop 'Variável imutável que permite o Looping infinito do script
Dim strADT 'Se utiliza do objHTML para armazenar o texto da área de transferência
Dim strADTAntiga 'Guarda o último texto da área de transferência para comparação
Dim objHTML 'Captura o texto da área de transferênca
Dim numErro 'Guarda o número do erro atual para que ele não mude durante o tratamento
Dim currTime 'Hora atual
Dim currDate 'Data atual
Dim Random 'Guarda um número aleatório que será utilizado em fileName para dar nome ao arquivo de log
Dim fileName 'Guarda o nome do arquivo de log
Dim objWMI 'Ainda não utilizado
Dim colProcesses 'Ainda não utilizado
Dim adtRodando 'Ainda não utilizado

'Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
'Set colHandles = objWMI.InstancesOf("Win32_Process")
'For Each objHandle In colHandles
'	If Not InStr(0, objHandle.CommandLine, "ADT.vbs", 0) = 0 Then
'		MsgBox "O ADT.vbs já está rodando!", vbOKOnly + vbInformation, "ADT"
'		WScript.Quit
'	End If
'Next
	
Randomize
Random = Rnd
Random = Replace(Random,",","")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objHTML = CreateObject("htmlfile")
fileName = Day(Date) & "-" & Month(Date) & "-" & Year(Date) & "_" & Random & ".log"
Set objTexto = objFSO.CreateTextFile(fileName, 1, 1)
If objFSO.FileExists(fileName) Then
	MsgBox "Foi criado o arquivo de armazenamento " & fileName, vbOKOnly + vbInformation, "ADT"
Else
	MsgBox "Falha ao criar o arquivo " & fileName, vbOKOnly + vbCritical, "ADT"
End If
strADTAntiga = Empty
varLoop = "."
Do Until varLoop = "Nunca Sair"
	strADT = objHTML.ParentWindow.ClipboardData.GetData("text")
	numErro = Err.Number
	If numErro = 0 Then
		If strADT = strADTAntiga Then
			WScript.Sleep 1000
		Else
			If IsNull(strADT) Then
				WScript.Sleep 1000
			ElseIf Not VarType(strADT) = vbString Then
				WScript.Sleep 1000
			Else
				objTexto.WriteLine "=================" & Date & " - " & Time & "=================" & vbCrLf & vbCrLf & strADT
				'WScript.Echo  "=================" & Date & " - " & Time & "=================" & vbCrLf & vbCrLf & strADT
				strADTAntiga = strADT
				numErro = Empty
			End If
		End If
	Else
		WScript.Sleep 1000
	End If
Loop
objTexto.Close