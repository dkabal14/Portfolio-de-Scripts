On Error Resume Next
Set objHTML = CreateObject("htmlfile")
strLogin = InputBox("Digite o login do usuário:", "Busca de Terceiros OI")

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
	"Usuário não encontrado!", vbOKOnly + vbExclamation, "Busca de Terceiros OI"
Else
	strTxt = _
	"Nome de Exibição: " & objUser.displayName & vbCrLf & _
	"E-mail: " & objUser.mail
	
	Resposta = MsgBox(strTxt & vbCrLf & vbCrLf & "Deseja copiar essas informações para a área de transferência do Windows?", vbYesNo + vbQuestion, "Busca de Terceiros OI")
	If Resposta = vbyes Then
		objIE.Navigate("about:blank")
		objIE.document.parentwindow.clipboardData.SetData "text", strTxt
		strAdT = objIE.Document.parentwindow.clipboardData.GetData("text")
		If strTxt = strAdT Then
			MsgBox "A informação foi adicionada à sua àrea de transferência" , vbOKOnly + vbInformation,  "Busca de Terceiros OI"
		Else
			MsgBox "Obs.: Ocorreu uma tentativa de copiar a informação para sua área de tranferênca, mas essa foi bloqueada por motivo de segurança" & vbCrLf & vbCrLf & _
			"Vá em inetcpl.cpl -> Segurança -> Internet -> Nível Personalizado" & vbCrLf & _
			"Em " & Chr(34) & "Script" & Chr(34) & " mude a opção " & Chr(34) & _
			"Permitir acesso Programático à área de Transferência" & Chr(34) & " para " & Chr(34) & "Habilitar" & chr(34), _
			vbOKOnly + vbExclamation,  "Busca de Terceiros OI"
		End If
	Else
		WScript.Quit
	End If
End If