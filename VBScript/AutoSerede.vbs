'Script escrito por Diego Ros�rio Sousa - diegorosariosousa@gmail.com
'Sonda - Suporte N�vel 3 RJ
'Option Explicit
'On Error Resume Next

'VARI�VEIS E CONSTANTES
'========================================================================================================
Dim strUsuarioAntigo 'Nome antigo que ser� alterado
Dim strUsuarioNovo 'Nome novo
Dim strComputador 'Nome do Computador de destino "." indica o pr�prio micro
Dim objWMI 'Puxa o objeto de WMI
Dim objProcesso 'Puxa a classe Win32_Process
Dim vetUsuarios 'Vetor com o objeto do WMI que executou a pesquisa do nome do usu�rio antigo
Dim iteUsuario 'Vari�vel do la�o que renomeia a propriedade do WMI utilizada para itera��o
Dim objUsuario 'objeto WinNT para altera��o das propriedades dos usu�rios locais
Dim intFlags 'Flags de dentro de objUsuario
Const ADS_UF_SCRIPT                                  = &h1 'flag do script de logon
Const ADS_UF_ACCOUNTDISABLE                          = &h2 'flag conta desabilitada
Const ADS_UF_HOMEDIR_REQUIRED                        = &h8 'flag Diret�rio do perfil
Const ADS_UF_LOCKOUT                                 = &h10 'flag Bloqueado
Const ADS_UF_PASSWD_NOTREQD                          = &h20 'flag senha n�o requerida 
Const ADS_UF_PASSWD_CANT_CHANGE                      = &h40 'flag senha nunca muda
Const ADS_UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED         = &h80 'flag senha de texto encriptado permitida
Const ADS_UF_TEMP_DUPLICATE_ACCOUNT                  = &h100 'flag conta tempor�rio ou duplicada
Const ADS_UF_NORMAL_ACCOUNT                          = &h200 'flag conta normal
Const ADS_UF_INTERDOMAIN_TRUST_ACCOUNT               = &h800 'flag conta confi�vel entredom�nios
Const ADS_UF_WORKSTATION_TRUST_ACCOUNT               = &h1000 'flag conta confi�vel de esta��o de trabalho
Const ADS_UF_SERVER_TRUST_ACCOUNT                    = &h2000 'flag conta confi�vel do servidor
Const ADS_UF_DONT_EXPIRE_PASSWD                      = &h10000 'flag senha nunca expira
Const ADS_UF_MNS_LOGON_ACCOUNT                       = &h20000 'flag conta de logon nms
Const ADS_UF_SMARTCARD_REQUIRED                      = &h40000 'flag SmartCard requerido
Const ADS_UF_TRUSTED_FOR_DELEGATION                  = &h80000 'flag confiado para delega��o
Const ADS_UF_NOT_DELEGATED                           = &h100000 'flag n�o delegado
Const ADS_UF_USE_DES_KEY_ONLY                        = &h200000 'flag somente chave
Const ADS_UF_DONT_REQUIRE_PREAUTH                    = &h400000 'flag n�o requer utentica��o
Const ADS_UF_PASSWORD_EXPIRED                        = &h800000 'flag sen expirada
Const ADS_UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION  = &h1000000 'flag confiado para autenticar para delega��o
Dim strPassword 'Novo password do user local
Dim strDescricao 'descri��o da conta criada
Const HKEY_CLASSES_ROOT   = &H80000000 'caminho para o hive de registro de HKEY_CLASSES_ROOT
Const HKEY_CURRENT_USER   = &H80000001 'caminho para o hive de registro de HKEY_CURRENT_USER
Const HKEY_LOCAL_MACHINE  = &H80000002 'caminho para o hive de registro de HKEY_LOCAL_MACHINE
Const HKEY_USERS          = &H80000003 'caminho para o hive de registro de HKEY_USERS
Const REG_SZ              = 1 'n�mero que identifica strings de registro
Const REG_EXPAND_SZ       = 2 'n�mero que identifica strings expandidas de registro
Const REG_BINARY          = 3 'n�mero que identifica bin�rios de registro
Const REG_DWORD           = 4 'n�mero que identifica DWORDS de registro
Const REG_MULTI_SZ        = 7 'n�mero que identifica multi strings de registro
Const JOIN_DOMAIN = 1
Const ACCT_CREATE = 2
Const ACCT_DELETE = 4
Const WIN9X_UPGRADE = 16
Const DOMAIN_JOIN_IF_JOINED = 32
Const JOIN_UNSECURE = 64
Const MACHINE_PASSWORD_PASSED = 128
Const DEFERRED_SPN_SET = 256
Const INSTALL_INVOCATION = 262144
Const SCCM_SERVER = "SCMPROD01.domain.corp.co"
Const DOMAIN = "domain.corp.co"
'========================================================================================================


'=============== Subs Ativos =================================
CriaSupervisor
CriaAdministrador
AtivaDNSAutomatico
ChamaPropriedadeNome
MsgBox "Fim do Script!" & vbCrLf & vbCrLf & "favor verificar se deu tudo certo ;)", vbOKOnly, "Automa��o Projeto Serede"
'=============================================================



'=============================================================
Sub AdicionaGrupos
End Sub
'=============================================================
Sub AlteraHostname 'Sub-rotina s� funciona com o sistema fora do dom�nio
	strComputador = "."

	strTipo = InputBox("Insira o tipo do computador" & vbCrLf & vbCrLf & "'D' para desktop" & vbCrLf & "'L' para laptop","Automa��o Projeto Serede")

	strPatrimonio = InputBox("Insira os cinco �ltimos n�meros da etiqueta de Patrim�nio (etiqueta de TI)",,"Automa��o Projeto Serede") 
	
	Set objWMIService = GetObject("winmgmts:\\" & strComputador & "\root\cimv2")
	
	Set colComputadores = objWMIService.ExecQuery("Select * from Win32_ComputerSystem")
	
	For Each objComputador in colComputadores
		If strTipo = "D" Then
			strPrefixo = "DSKPSRD0"
		ElseIf strTipo = "L" Then
			strPrefixo = "LAPPSRD0"
		Else
			WScript.Echo "TIPO DIGITADO INCORRETAMENTE, FAVOR INSERIR A INFORMA��O CORRETA"
			WScript.Quit
		End If
		objComputador.Rename(strPrefixo & strPatrimonio)
	Next
	WScript.Echo "AlteraHostname Feito!"
End Sub
'=================================================================================================
Sub AtivaDNSAutomatico 'Ativa a busca autom�tica do DNS
	strComputador = "."
	Set objWMI = GetObject("WinMgmts:\\" & strComputador & "\root\cimv2")
	Set objRegistry = objWMI.Get("StdRegProv")
	arrControlSet = Array("SYSTEM\ControlSet001\Services\Tcpip\Parameters\Interfaces","SYSTEM\ControlSet002\Services\Tcpip\Parameters\Interfaces","SYSTEM\ControlSet003\Services\Tcpip\Parameters\Interfaces","SYSTEM\ControlSet004\Services\Tcpip\Parameters\Interfaces","SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces")
	strValor = "NameServer"
	novoValor = ""
	
		
	For Each ControlSet In arrControlSet
		objRegistry.EnumKey HKEY_LOCAL_MACHINE,ControlSet,colChaves
		For Each Chave In colChaves
			objRegistry.SetStringValue HKEY_LOCAL_MACHINE,ControlSet & "\" & Chave,strValor,novoValor
		Next
	Next
	Wscript.Echo "Ativa DHCP Feito!"
End Sub
'=================================================================================================
Sub ChamaPropriedadeNome 'Chama a janela de propriedades de nome do computador
	Set objWshShell = CreateObject("Wscript.Shell")
	objWshShell.Run "C:\Windows\System32\SystemPropertiesComputerName.exe",1,True
End Sub
'=================================================================================================
Sub CriaAdministrador 'Cria o fake ADM, seta a senha, descri��o e as flags necess�rias
	strComputador = "."
	strUsuarioNovo = "Administrador"
	strPassword = "Telemar@31"
	
	Set objWMI = GetObject("WinMgmts:\\" & strComputador & "\root\cimv2")
	Set objProcesso = objWMI.Get("Win32_Process")
	objProcesso.Create "CMD /C NET USER /ADD " & strUsuarioNovo & " " & strPassword
	WScript.Sleep 10000
	
	Set objUsuario = GetObject("WinNT://" & strComputador & "/" & strUsuarioNovo & ",user")
	objUsuario.FullName = strUsuarioNovo
	objUsuario.Description = "Nova descricao alterada por script"
	intFlags = objUsuario.Get("UserFlags")
	intFlags = intFlags Or ADS_UF_DONT_EXPIRE_PASSWD Or ADS_UF_PASSWD_CANT_CHANGE Or ADS_UF_ACCOUNTDISABLE
	objUsuario.Put "userFlags", intFlags
	objUsuario.SetInfo
	
	Set objGrupo = GetObject("WinNT://" & strComputador & "/Usu�rios")
	For Each iteUsuario In objGrupo.Members
		If InStr(iteUsuario.adspath,strUsuarioNovo) > 0 Then
			objGrupo.Remove(iteUsuario.AdsPath)
		End If
	Next
	WScript.Echo "CriaAdministrador Feito!"
End Sub
'=================================================================================================
Sub CriaSupervisor 'Cria o usu�rio supervisor, seta a senha padr�o e a descri��o
	strUsuarioAntigo = "Administrador"
	strUsuarioNovo = "Supervisor"
	strSenha = "#SUPPORT13s123"
	strDescricao = "Conta interna para a administra��o do computador/dom�nio"
	
	strComputador = "."
	Set objWMI = GetObject("WinMgmts:\\" & strComputador & "\root\Cimv2")
	Set objProcesso = objWMI.Get("Win32_Process")
	Set vetUsuarios = objWMI.ExecQuery("SELECT * FROM Win32_UserAccount WHERE name='" & strUsuarioAntigo & "'")
	
	For Each iteUsuario In vetUsuarios
		iteUsuario.Rename(strUsuarioNovo)
	Next
	
	Set objUsuario = GetObject("WinNT://" & strComputador & "/" & strUsuarioNovo & ",user")
	objUsuario.FullName = strUsuarioNovo
	objUsuario.SetPassword strSenha
	objUsuario.Description = strDescricao
	intFlags = objUsuario.Get("UserFlags")
	intFlags = intFlags Or ADS_UF_DONT_EXPIRE_PASSWD
	objUsuario.Put "userFlags", intFlags
	objUsuario.SetInfo
	objProcesso.Create "CMD /C NET USER " & strUsuarioNovo & " /ACTIVE:YES"
	WScript.Echo "CriaSupervisor Feito!"
End Sub
'=================================================================================================
Function DiretorioDoScript 'Retorna o diret�rio do Script
	DiretorioDoScript = Replace(WScript.ScriptFullName,WScript.ScriptName,"")
End Function
'=================================================================================================
Sub InsereDominio
	strDomain = DOMAIN
	strPassword = "Senha"
	strUser = "TCXXXXXX"
	 
	Set objNetwork = CreateObject("WScript.Network")
	strComputer = objNetwork.ComputerName
	 
	Set objComputer = GetObject("winmgmts:{impersonationLevel=Impersonate}!\\" & strComputer & "\root\cimv2:Win32_ComputerSystem.Name='" & strComputer & "'")
	 
	ReturnValue = objComputer.JoinDomainOrWorkGroup(strDomain, strPassword, strDomain & "\" & strUser, NULL, JOIN_DOMAIN + ACCT_CREATE)
		WScript.Echo "InsereDominio Feito!"
End Sub
'=================================================================================================
Sub InstalaCyberS 'Inicia a instala��o do CyberS
	Set objWshShell = CreateObject("Wscript.Shell")
	objWshShell.Run DiretorioDoScript & "\CyberS\Install_Cybers.exe",1,True
	WScript.Echo "InstalaCyberS Feito!"
End Sub
'=================================================================================================
Sub InstalaSCCM
	Set objWshShell = CreateObject("Wscript.Shell")
	objWshShell.Run DiretorioDoScript & "\SystemCenterConfigurationManager\ccmsetup.exe /mp:" & SCCM_SERVER & " SMSSITECODE=DCM DNSSUFFIX=" & DOMAIN & " FSP=" & SCCM_SERVER & " /BITSPriority:HIGH",1,True
	WScript.Echo "InstalaSCCM Feito!"
End Sub
'=================================================================================================
Sub InstalaSEP32 'Inicia a instala��o do SEP 32 bits
	Set objWshShell = CreateObject("Wscript.Shell")
	objWshShell.Run DiretorioDoScript & "\SymantecEndpointProtecton_32\Sep.msi /qb! /l*v " & Chr(34) & DiretorioDoScript & "\SEP_INST.LOG" & Chr(34),1,True
	WScript.Echo "InstalaSEP Feito!"
End Sub
'=================================================================================================
Sub InstalaSEP64 'Inicia a instala��o do SEP 64 bits
	Set objWshShell = CreateObject("Wscript.Shell")
	objWshShell.Run DiretorioDoScript & "\SymantecEndpointProtecton_64\Sep64.msi /qb! /l*v " & Chr(34) & DiretorioDoScript & "\SEP_INST.LOG" & Chr(34),1,True
	WScript.Echo "InstalaSEP Feito!"
End Sub
'=================================================================================================
Sub InventarioSerede
End Sub
'=================================================================================================
Sub RemoveKaspersky
	WScript.Echo "RemoveKaspersky Feito!"
End Sub
'=================================================================================================
Sub RetiraDoDominio
	strUsuario = "Oi"
	strSenha = "Oi"
	
	Set objNetwork = CreateObject("WScript.Network")
	strComputador = objNetwork.ComputerName
	
	Set objComputador = GetObject("winmgmts:\\" & strComputador & "\root\cimv2:Win32_ComputerSystem.Name='" & strComputador & "'")
	strDominio = objComputador.Domain
	intRetorna = objComputador.UnjoinDomainOrWorkgroup(strSenha, strDominio & "\" & strUsuario)
End Sub
'=================================================================================================