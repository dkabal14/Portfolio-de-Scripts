Set objShell = CreateObject("Shell.Application")

objShell.ShellExecute "diskpart.exe", "/s " & DiretorioScript & "DiskPart_Script.txt", "", "runas", 1

Function DiretorioScript 'Retorna o diretório do Script
	DiretorioScript = Replace(WScript.ScriptFullName,WScript.ScriptName,"")
End Function