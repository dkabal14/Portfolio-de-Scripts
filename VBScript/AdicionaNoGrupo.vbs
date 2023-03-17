

ColocaUsuarioNoGrupo

'============================================================
Sub ColocaUsuarioNoGrupo
	Set objGrupoLocal = GetObject("WinNT://./Administradores,group")
	
	arrGrupos = Array("Admin1","Admin2","Admin 3","Admin 4")
	
	For Each objGrupo In arrGrupos
		Set objDomainUser = GetObject("WinNT://domain.net.co/" & objGrupo & ",group")
		If (objLocalGroup.IsMember(objDomainUser.ADsPath) = False) Then
		    objLocalGroup.Add(objDomainUser.ADsPath)
		End If
	Next
	WScript.Echo "Sub-rotina ColocaUsuarioNoGrupo Terminou"
	
End Sub
'==============================================================