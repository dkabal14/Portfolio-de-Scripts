'AGENDAMENTO DE LEMBRETES
'Descrição: Este script foi desenvolvido para agendar lembretes com facilidade.
'Autor: Diego Rosário Sousa
'e-mail: diegorosariosousa@gmail.com


Do Until Sair = "Sim"
	subPrincipal
	Escolha = MsgBox("Deseja agendar uma novo lembrete?", vbYesNo + vbQuestion, "Agendamento de Lembretes")
	If Escolha = vbNo Then
		MsgBox "Se o computador for reiniciado, todos os lembretes serão perdidos", vbOKOnly + vbInformation, "Agendamento de Lembretes"
		Sair = "Sim"
	End If
Loop

Private Sub subPrincipal
	varNomeAgendamento = NomeAgendamento
	varDataAgendamento = DataAgendamento
	varHorarioAgendamento = HorarioAgendamento
	Set objShell = CreateObject("Shell.Application")
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	If Not objFSO.FolderExists(DiretorioScript & "Lembretes_Agendados") Then
		objFSO.CreateFolder DiretorioScript & "Lembretes_Agendados"
	End If
	Set objTexto = objFSO.CreateTextFile(DiretorioScript & "Lembretes_Agendados\" & FormatoNomeArquivo(varNomeAgendamento) & ".vbs",1)
	objTexto.WriteLine "DataAgendamento = " & Chr(34) & varDataAgendamento & Chr(34)
	objTexto.WriteLine "HorarioAgendamento = " & Chr(34) & varHorarioAgendamento & Chr(34)
	objTexto.WriteLine "Do Until Sair = " & Chr(34) & "sim" & Chr(34)
	objTexto.WriteLine "	If Day(DataAgendamento) = Day(Date) And Month(DataAgendamento) = Month(Date) Then"
	objTexto.WriteLine "		If Hour(HorarioAgendamento) = Hour(Time) And Minute(HorarioAgendamento) = Minute(Time) Then"
	objTexto.WriteLine "			MsgBox " & Chr(34) & "LEMBRETE: " & varNomeAgendamento & "!!!" & Chr(34) & ",vbOKOnly + vbInformation, " & Chr(34) & "Agendamento de Lembretes" & Chr(34)
	objTexto.WriteLine "			Sair = " & Chr(34) & "sim" & Chr(34)
	objTexto.WriteLine "		Else"
	objTexto.WriteLine "			WScript.Sleep 10000"
	objTexto.WriteLine "		End If"
	objTexto.WriteLine "	Else"
	objTexto.WriteLine "		WScript.Sleep 10000"
	objTexto.WriteLine "	End If"
	objTexto.WriteLine "Loop"
	objTexto.WriteLine "Set objFSO = CreateObject(" & Chr(34) & "Scripting.FileSystemObject" & chr(34) & ")"
	objTexto.WriteLine "objFSO.DeleteFile Wscript.ScriptFullName"
	objTexto.Close
	objShell.ShellExecute "cscript.exe", Chr(34) & DiretorioScript & "Lembretes_Agendados\" & FormatoNomeArquivo(varNomeAgendamento) & ".vbs" & Chr(34), "", "runas", 0
	If objFSO.FileExists(DiretorioScript & "Lembretes_Agendados\" & FormatoNomeArquivo(varNomeAgendamento) & ".vbs") Then
		MsgBox "Lembrete Agendado!", vbOKOnly + vbInformation, "Agendamento de Lembretes"
	Else
		MsgBox "Houve um erro ao criar o agendamento!" & vbCrLf & vbCrLf & "Verifique se há caracteres especiais no nome do lembrete e/ou se você tem permissão de acesso à pasta do programa.", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
	End If
End Sub
'==============================================================
Function NomeAgendamento 'Retorna o nome do agendamento
	Do Until NomeCorreto = "Sim"
		txtNomeAgendamento = InputBox("Digite o nome do lembrete: " & vbCrLf & vbCrLf & vbCrLf & "NOTA:Evite usar caracteres especiais.","Agendamento de Lembretes","Lembrete")
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		If txtNomeAgendamento = "" Or txtNomeAgendamento = vbCancel Then
			txtNomeAgendamentoNulo = MsgBox("Você clicou em cancelar ou não digitou nenhum valor." & vbCrLf & vbCrLf & "Quer sair do programa?", vbYesNo, "Agendamento de Lembretes")
			If txtNomeAgendamentoNulo = vbYes Then
				WScript.Quit
			Else
				MsgBox "Você deve digitar um nome para a tarefa!", vbOKOnly + vbInformation, "Agendamento de Lembretes"
				NomeCorreto = "Nao"
			End If
		ElseIf objFSO.FileExists(DiretorioScript & "Lembretes_Agendados\" & FormatoNomeArquivo(txtNomeAgendamento) & ".vbs") Then
			nomeAgendamentoJaExiste = MsgBox("Já existe um lembrete agendado com o nome " & txtNomeAgendamento & vbCrLf & vbCrLf & "Deseja substituí-lo?", vbYesNo + vbQuestion, "Agendamento de Lembretes")
			If nomeAgendamentoJaExiste = vbYes Then
				NomeAgendamento = txtNomeAgendamento
				NomeCorreto = "Sim"
			Else
				NomeCorreto = "Nao"
			End If
		Else
			NomeAgendamento = txtNomeAgendamento
			NomeCorreto = "Sim"
		End If
	Loop
End Function
'==============================================================
Function DataAgendamento 'Retorna a data do agendamento
	Do Until DataCorreta = "Sim"
		txtDataAgendamento = InputBox("Digite a data do agendamento no formato: DD/MM","Agendamento de Lembretes",Day(Date) & "/" & Month(Date))
		If txtDataAgendamento = "" Or txtDataAgendamento = vbCancel Then
			txtDataAgendamentoNulo = MsgBox("Você clicou em cancelar ou não digitou nenhum valor." & vbCrLf & vbCrLf & "Deseja sair do programa?", vbYesNo + vbQuestion, "Agendamento de Lembretes")
			If txtDataAgendamentoNulo = vbYes Then
				WScript.Quit
			Else
				DataCorreta = "Nao"
			End If
		ElseIf IsDate(txtDataAgendamento) = True Then
			DataAgendamento = txtDataAgendamento
			DataCorreta = "Sim"
		Else
			MsgBox "A data está no formato incorreto!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
			DataCorreta = "Nao"
		End If
	Loop
End Function
'=================================================================
Function HorarioAgendamento 'Retorna o horário do agendamento
	Do Until HoraCorreta = "Sim"
		txtHorarioAgendamento = InputBox("Digite o horário do agendamento no formato hh:mm","Agendamento de Lembretes")
		If txtHorarioAgendamento = "" Or txtHorarioAgendamento = vbCancel Then
			txtHorarioAgendamentoNulo = MsgBox("Você clicou em cancelar ou não digitou nenhum valor." & vbCrLf & vbCrLf & "Deseja sair do programa?", vbYesNo + vbQuestion, "Agendamento de Lembretes")
			If txtHorarioAgendamentoNulo = vbYes Then
				WScript.Quit
			Else
				HoraCorreta = "Nao"
			End If
		ElseIf InStr(1,txtHorarioAgendamento,":",1) = "0" Then
			MsgBox "A hora está no formato incorreto!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
			HoraCorreta = "Nao"
		Else
			numHora = Mid(txtHorarioAgendamento, 1, (InStr(1,txtHorarioAgendamento,":",1) - 1))
			numMinuto = Mid(txtHorarioAgendamento, (InStr(1,txtHorarioAgendamento,":",1) + 1), Len(txtHorarioAgendamento))
			If Not IsNumeric(numHora) Then 
				MsgBox "A hora está no formato incorreto!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
				HoraCorreta = "Nao"
			ElseIf Not IsNumeric(numMinuto) Then
				MsgBox "A hora está no formato incorreto!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
				HoraCorreta = "Nao"
			ElseIf Not Len(numHora) < "3" Then
				MsgBox "A hora está no formato incorreto!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
				HoraCorreta = "Nao"
			ElseIf Not Len(numMinuto) < "3" Then
				MsgBox "A hora está no formato incorreto!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
				HoraCorreta = "Nao"
			ElseIf numHora > "23" Then
				MsgBox "A hora está no formato incorreto!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
				HoraCorreta = "Nao"
			ElseIf numMinuto > "59" Then
				MsgBox "A hora está no formato incorreto!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
				HoraCorreta = "Nao"
			ElseIf numMinuto <= Minute(Time) Then
				If numHora < Hour(Time) Then
					MsgBox "O horário deve ser posterior ao atual!", vbOKOnly + vbExclamation, "Agendamento de Lembretes"
					HoraCorreta = "Nao"
				End If
			Else
				HorarioAgendamento = numHora & ":" & numMinuto
				HoraCorreta = "Sim"
			End If
		End If
	Loop
End Function
'=================================================================
Function DiretorioScript 'Retorna o diretório do Script
	DiretorioScript = Replace(WScript.ScriptFullName,WScript.ScriptName,"")
End Function
'=================================================================
Function FormatoNomeArquivo(Texto) 'Formata o texto de uma variável para adequá-lo ao nome de um arquivo
	Texto = Replace(Texto, "\", "+")
	Texto = Replace(Texto, "/", "+")
	Texto = Replace(Texto, ":", "+")
	Texto = Replace(Texto, "*", "+")
	Texto = Replace(Texto, "?", "+")
	Texto = Replace(Texto, Chr(34), "+")
	Texto = Replace(Texto, "<", "+")
	Texto = Replace(Texto, ">", "+")
	FormatoNomeArquivo = Texto
End Function
