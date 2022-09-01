Dim IrProx, A, Null_Choice, B, Delta, RDelta, X1, X2, Fim, Xv, Yv, Ponto

'A' DEVE SER DIFERENTE DE ZERO, 'A' NÃO PODE SER NULO, 'A' DEVE SER NUMÉRICO.

Fim = 0
Do Until Fim = 1
	Do Until IrProx = 1
		A = InputBox("Y = ( A )x² + ( B )x + ( C )" & vbCrLf & vbCrLf & _
		"Digite o valor de " & Chr(34) & "A" & Chr(34), "Bháskara")
		
		If A = Empty Then ' Ação para A vazio
			Null_Choice = MsgBox("Você clicou em cancelar ou não digitou nenhum valor, Deseja sair do programa?", vbYesNo, "Bháskara")
			
			If Null_Choice = vbYes Then
				WScript.Quit
			Else
				MsgBox Chr(34) & "A" & Chr(34) & " Deve ser diferente de " & Chr(34) & "0" & Chr(34) & ", caso contrário, esta seria uma equação de primeiro grau.", vbOKOnly, "Bháskara"
				IrProx = Empty
				Null_Choice = Empty
				A = Empty
			End If
		
		ElseIf A = "0" Then 'Ação para A = 0
			
			MsgBox Chr(34) & "A" & Chr(34) & " Deve ser diferente de " & Chr(34) & "0" & Chr(34) & ", caso contrário, esta seria uma equação de primeiro grau.", vbOKOnly, "Bháskara"
			IrProx = Empty
			A = Empty
			
		ElseIf Not IsNumeric(A) Then 'Ação para A não numérico
			
			MsgBox Chr(34) & "A" & Chr(34) & " Deve ser um valor numérico.", vbOKOnly, "Bháskara"
			IrProx = Empty
			A = Empty
		Else
			IrProx = 1
		End If
	Loop
	IrProx = Empty
	A = CLng(A)
	
	
	Do Until IrProx = 1
		B = InputBox("Y = ( " & A & " )x² + ( B )x + ( C )" & vbCrLf & vbCrLf & _
		"Digite o valor de " & Chr(34) & "B" & Chr(34), "Bháskara")
		
		If B = Empty Then
			Null_Choice = MsgBox("Você clicou em cancelar ou não digitou nenhum valor, Deseja sair do programa?", vbYesNo, "Bháskara")
			
			If Null_Choice = vbYes Then
				WScript.Quit
			Else
				MsgBox "Zero não é o mesmo que nulo.", vbOKOnly, "Bháskara"
				IrProx = Empty
				Null_Choice = Empty
				A = Empty
			End If
			
		ElseIf Not IsNumeric(B) Then 
			
			MsgBox Chr(34) & "B" & Chr(34) & " Deve ser um valor numérico.", vbOKOnly, "Bháskara"
			IrProx = Empty
			B = Empty
		Else
			IrProx = 1
		End If
	Loop
	IrProx = Empty
	B = CLng(B)
		
	
	Do Until IrProx = 1
		C = InputBox("Y = ( " & A & " )x² + ( " & B & " )x + ( C )" & vbCrLf & vbCrLf & _
		"Digite o valor de " & Chr(34) & "C" & Chr(34), "Bháskara")
		
		If C = Empty Then
			Null_Choice = MsgBox("Você clicou em cancelar ou não digitou nenhum valor, Deseja sair do programa?", vbYesNo, "Bháskara")
			
			If Null_Choice = vbYes Then
				WScript.Quit
			Else
				MsgBox "Zero não é o mesmo que nulo." , vbOKOnly, "Bháskara"
				IrProx = Empty
				Null_Choice = Empty
				C = Empty
			End If
			
		ElseIf Not IsNumeric(C) Then 
			
			MsgBox Chr(34) & "C" & Chr(34) & " Deve ser um valor numérico.", vbOKOnly, "Bháskara"
			IrProx = Empty
			C = Empty
		Else
			IrProx = 1
		End If
	Loop
	IrProx = Empty
	C = CLng(C)
	
	
'COMEÇA O CÁLCULO	

	
	Delta = (B^2) - (4*A*C)
	Xv = (-B) / (2*A)
	Yv = (-Delta) / (4*A)
	
	
	If Delta >= 0 Then
		RDelta = Delta^(0.5)
		Fim = 1
	Else
		MsgBox "A equação Y = ( " & A & " )x² + ( " & B & " )x + ( " & C & " ) não existe no domínio de R²", vbOKOnly, "Bháskara"
	End if
Loop

X1 = ((-B) + RDelta) / 2*A
X2 = ((-B) - RDelta) / 2*A
If A > 0 Then
	Ponto = "ponto de mínima"
Else
	Ponto = "ponto de máxima"
End If

MsgBox "Resultados para a equação: Y = ( " & A & " )x² + ( " & B & " )x + ( " & C & " )" & vbCrLf & _
	   "X1= " & X1 & vbCrLf & _
       "X2= " & X2 & vbCrLf & _
       vbCrLf & _
       "E tem seu " & Ponto & " em: " & vbCrLf & _
       "Xv = " & Xv & vbCrLf & _
       "Yv = " & Yv, vbOKOnly, "Bháskara"