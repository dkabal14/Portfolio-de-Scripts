strComputador = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputador & "\root\rsop\computer")

Set colItems = objWMIService.ExecQuery _
    ("Select * from RSOP_SecuritySettingNumeric")

For Each objItem in colItems
	If objItem.KeyName = "MinimumPasswordLength" And objItem.Precedence = "1" Then
		If objItem.Setting > 8 Then
			MsgBox "O comprimento mínimo de senha é maior que 8." & vbCrLf & vbCrLf & "O U2000 LCT não pode ser instalado no equipamento."
		Else
			MsgBox "O Comprimento mínimo de senha é: " & objItem.Setting & vbCrLf & vbCrLf & "O U2000 LCT pode ser instalado no equipamento."
		End If
	End If
Next