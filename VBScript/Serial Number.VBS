strComputer = InputBox("Digite o nome do computador: " & vbCrLf, "SerialNumber", "localhost")
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colBIOS = objWMIService.ExecQuery _
    ("Select * from Win32_BIOS")

For each objBIOS in colBIOS
    Wscript.Echo "Serial Number: " & objBIOS.SerialNumber
Next