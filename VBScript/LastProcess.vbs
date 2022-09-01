' Monitor Process Creation

' Windows Server 2003 : Yes
' Windows XP : Yes
' Windows 2000 : Yes
' Windows NT 4.0 : Yes
' Windows 98 : Yes
Set objFSO = CreateObject("Scripting.FileSystemObject")
fileName = "Monitoramento_" & Day(Date) & "-" & Month(Date) & "-" & Year(Date) & "_" & Random & ".log"
Set objTexto = objFSO.CreateTextFile(fileName, 1, 1)
If objFSO.FileExists(fileName) Then
	MsgBox "Foi criado o arquivo de armazenamento " & fileName, vbOKOnly + vbInformation, "ADT"
Else
	MsgBox "Falha ao criar o arquivo " & fileName, vbOKOnly + vbCritical, "ADT"
End If


strComputer = InputBox("Digite o nome da máquina:","monitoramento")

Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colMonitoredProcesses = objWMIService.ExecNotificationQuery(_
"select * from __instancecreationevent within 1 where TargetInstance isa 'Win32_Process'"_
)

i = 0
Do While i = 0
    Set objLatestProcess = colMonitoredProcesses.NextEvent
    WScript.Echo "====================================================" & vbCrLf
    Wscript.Echo Now & " - " & objLatestProcess.TargetInstance.CommandLine & vbCrLf
    objTexto.WriteLine "====================================================" & vbCrLf
    objTexto.WriteLine Now & " - " & objLatestProcess.TargetInstance.CommandLine & vbCrLf
Loop