On Error Resume Next
Set objHTML = CreateObject("htmlfile")
strLogin = InputBox("Digite o login do usu�rio:", "Busca de Terceiros OI")

Set objIE = CreateObject("InternetExplorer.Application")


Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=AC,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=AL,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=AM,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=AP,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=BA,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=CE,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=DF,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=ES,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=GO,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=MA,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=MG,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=MS,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=MT,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=PA,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=PB,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=PE,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=PI,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=PR,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=RJ,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=RN,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=RO,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=RR,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=RS,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=SC,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=SE,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=SP,OU=Oi,DC=oi,DC=corp,DC=net")
If Not Err.Number = 0 Then
Set objUser = GetObject("LDAP://CN=" & strLogin & ",OU=Terceiros,OU=Usuarios,OU=Filial,OU=TO,OU=Oi,DC=oi,DC=corp,DC=net")
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If
End If

If objUser.givenName = Null Then
	MsgBox _
	"Usu�rio n�o encontrado!", vbOKOnly + vbExclamation, "Busca de Terceiros OI"
Else
	strTxt = _
	"Nome de Exibi��o: " & objUser.displayName & vbCrLf & _
	"E-mail: " & objUser.mail
	
	Resposta = MsgBox(strTxt & vbCrLf & vbCrLf & "Deseja copiar essas informa��es para a �rea de transfer�ncia do Windows?", vbYesNo + vbQuestion, "Busca de Terceiros OI")
	If Resposta = vbyes Then
		objIE.Navigate("about:blank")
		objIE.document.parentwindow.clipboardData.SetData "text", strTxt
		strAdT = objIE.Document.parentwindow.clipboardData.GetData("text")
		If strTxt = strAdT Then
			MsgBox "A informa��o foi adicionada � sua �rea de transfer�ncia" , vbOKOnly + vbInformation,  "Busca de Terceiros OI"
		Else
			MsgBox "Obs.: Ocorreu uma tentativa de copiar a informa��o para sua �rea de tranfer�nca, mas essa foi bloqueada por motivo de seguran�a" & vbCrLf & vbCrLf & _
			"V� em inetcpl.cpl -> Seguran�a -> Internet -> N�vel Personalizado" & vbCrLf & _
			"Em " & Chr(34) & "Script" & Chr(34) & " mude a op��o " & Chr(34) & _
			"Permitir acesso Program�tico � �rea de Transfer�ncia" & Chr(34) & " para " & Chr(34) & "Habilitar" & chr(34), _
			vbOKOnly + vbExclamation,  "Busca de Terceiros OI"
		End If
	Else
		WScript.Quit
	End If
End If