

ColocaUsuarioNoGrupo

'============================================================
Sub ColocaUsuarioNoGrupo
	Set objGrupoLocal = GetObject("WinNT://./Administradores,group")
	
	arrGrupos = Array("OIDESKADMIN_OI","OIDESKADMIN","Sonda_Onsite OI","Sonda_Onsite")
	
	For Each objGrupo In arrGrupos
		Set objDomainUser = GetObject("WinNT://oi.corp.net/" & objGrupo & ",group")
		If (objLocalGroup.IsMember(objDomainUser.ADsPath) = False) Then
		    objLocalGroup.Add(objDomainUser.ADsPath)
		End If
	Next
	WScript.Echo "Sub-rotina ColocaUsuarioNoGrupo Terminou"
	
End Sub
'==============================================================