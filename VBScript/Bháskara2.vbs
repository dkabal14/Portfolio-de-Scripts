Dim IrProx, A, Null_Choice, B, Delta, RDelta, X1, X2, Fim, Xv, Yv, Ponto

'A' DEVE SER DIFERENTE DE ZERO, 'A' N�O PODE SER NULO, 'A' DEVE SER NUM�RICO.

Fim = 0
Do Until Fim = 1
	Do Until IrProx = 1
		A = InputBox("Y = ( A )x� + ( B )x + ( C )" & vbCrLf & vbCrLf & _
		"Digite o valor de " & Chr(34) & "A" & Chr(34), "Bh�skara")
		
		If A = Empty Then ' A��o para A vazio
			Null_Choice = MsgBox("Voc� clicou em cancelar ou n�o digitou nenhum valor, Deseja sair do programa?", vbYesNo, "Bh�skara")
			
			If Null_Choice = vbYes Then
				WScript.Quit
			Else
				MsgBox Chr(34) & "A" & Chr(34) & " Deve ser diferente de " & Chr(34) & "0" & Chr(34) & ", caso contr�rio, esta seria uma equa��o de primeiro grau.", vbOKOnly, "Bh�skara"
				IrProx = Empty
				Null_Choice = Empty
				A = Empty
			End If
		
		ElseIf A = "0" Then 'A��o para A = 0
			
			MsgBox Chr(34) & "A" & Chr(34) & " Deve ser diferente de " & Chr(34) & "0" & Chr(34) & ", caso contr�rio, esta seria uma equa��o de primeiro grau.", vbOKOnly, "Bh�skara"
			IrProx = Empty
			A = Empty
			
		ElseIf Not IsNumeric(A) Then 'A��o para A n�o num�rico
			
			MsgBox Chr(34) & "A" & Chr(34) & " Deve ser um valor num�rico.", vbOKOnly, "Bh�skara"
			IrProx = Empty
			A = Empty
		Else
			IrProx = 1
		End If
	Loop
	IrProx = Empty
	A = CLng(A)
	
	
	Do Until IrProx = 1
		B = InputBox("Y = ( " & A & " )x� + ( B )x + ( C )" & vbCrLf & vbCrLf & _
		"Digite o valor de " & Chr(34) & "B" & Chr(34), "Bh�skara")
		
		If B = Empty Then
			Null_Choice = MsgBox("Voc� clicou em cancelar ou n�o digitou nenhum valor, Deseja sair do programa?", vbYesNo, "Bh�skara")
			
			If Null_Choice = vbYes Then
				WScript.Quit
			Else
				MsgBox "Zero n�o � o mesmo que nulo.", vbOKOnly, "Bh�skara"
				IrProx = Empty
				Null_Choice = Empty
				A = Empty
			End If
			
		ElseIf Not IsNumeric(B) Then 
			
			MsgBox Chr(34) & "B" & Chr(34) & " Deve ser um valor num�rico.", vbOKOnly, "Bh�skara"
			IrProx = Empty
			B = Empty
		Else
			IrProx = 1
		End If
	Loop
	IrProx = Empty
	B = CLng(B)
		
	
	Do Until IrProx = 1
		C = InputBox("Y = ( " & A & " )x� + ( " & B & " )x + ( C )" & vbCrLf & vbCrLf & _
		"Digite o valor de " & Chr(34) & "C" & Chr(34), "Bh�skara")
		
		If C = Empty Then
			Null_Choice = MsgBox("Voc� clicou em cancelar ou n�o digitou nenhum valor, Deseja sair do programa?", vbYesNo, "Bh�skara")
			
			If Null_Choice = vbYes Then
				WScript.Quit
			Else
				MsgBox "Zero n�o � o mesmo que nulo." , vbOKOnly, "Bh�skara"
				IrProx = Empty
				Null_Choice = Empty
				C = Empty
			End If
			
		ElseIf Not IsNumeric(C) Then 
			
			MsgBox Chr(34) & "C" & Chr(34) & " Deve ser um valor num�rico.", vbOKOnly, "Bh�skara"
			IrProx = Empty
			C = Empty
		Else
			IrProx = 1
		End If
	Loop
	IrProx = Empty
	C = CLng(C)
	
	
'COME�A O C�LCULO	

	
	Delta = (B^2) - (4*A*C)
	Xv = (-B) / (2*A)
	Yv = (-Delta) / (4*A)
	
	
	If Delta >= 0 Then
		RDelta = Delta^(0.5)
		Fim = 1
	Else
		MsgBox "A equa��o Y = ( " & A & " )x� + ( " & B & " )x + ( " & C & " ) n�o existe no dom�nio de R�", vbOKOnly, "Bh�skara"
	End if
Loop

X1 = ((-B) + RDelta) / 2*A
X2 = ((-B) - RDelta) / 2*A
If A > 0 Then
	Ponto = "ponto de m�nima"
Else
	Ponto = "ponto de m�xima"
End If

MsgBox "Resultados para a equa��o: Y = ( " & A & " )x� + ( " & B & " )x + ( " & C & " )" & vbCrLf & _
	   "X1= " & X1 & vbCrLf & _
       "X2= " & X2 & vbCrLf & _
       vbCrLf & _
       "E tem seu " & Ponto & " em: " & vbCrLf & _
       "Xv = " & Xv & vbCrLf & _
       "Yv = " & Yv, vbOKOnly, "Bh�skara"