'Script escrito por Diego Rosário Sousa - diegos.sonda@contratada.oi.net.br
'Sonda - Suporte Nível 3 RJ
'Option Explicit
'On Error Resume Next

'VARIÁVEIS E CONSTANTES
'========================================================================================================
Dim strUsuarioAntigo 'Nome antigo que será alterado
Dim strUsuarioNovo 'Nome novo
Dim strComputador 'Nome do Computador de destino "." indica o próprio micro
Dim objWMI 'Puxa o objeto de WMI
Dim objProcesso 'Puxa a classe Win32_Process
Dim vetUsuarios 'Vetor com o objeto do WMI que executou a pesquisa do nome do usuário antigo
Dim iteUsuario 'Variável do laço que renomeia a propriedade do WMI utilizada para iteração
Dim objUsuario 'objeto WinNT para alteração das propriedades dos usuários locais
Dim intFlags 'Flags de dentro de objUsuario
Const ADS_UF_SCRIPT                                  = &h1 'flag do script de logon
Const ADS_UF_ACCOUNTDISABLE                          = &h2 'flag conta desabilitada
Const ADS_UF_HOMEDIR_REQUIRED                        = &h8 'flag Diretório do perfil
Const ADS_UF_LOCKOUT                                 = &h10 'flag Bloqueado
Const ADS_UF_PASSWD_NOTREQD                          = &h20 'flag senha não requerida 
Const ADS_UF_PASSWD_CANT_CHANGE                      = &h40 'flag senha nunca muda
Const ADS_UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED         = &h80 'flag senha de texto encriptado permitida
Const ADS_UF_TEMP_DUPLICATE_ACCOUNT                  = &h100 'flag conta temporário ou duplicada
Const ADS_UF_NORMAL_ACCOUNT                          = &h200 'flag conta normal
Const ADS_UF_INTERDOMAIN_TRUST_ACCOUNT               = &h800 'flag conta confiável entredomínios
Const ADS_UF_WORKSTATION_TRUST_ACCOUNT               = &h1000 'flag conta confiável de estação de trabalho
Const ADS_UF_SERVER_TRUST_ACCOUNT                    = &h2000 'flag conta confiável do servidor
Const ADS_UF_DONT_EXPIRE_PASSWD                      = &h10000 'flag senha nunca expira
Const ADS_UF_MNS_LOGON_ACCOUNT                       = &h20000 'flag conta de logon nms
Const ADS_UF_SMARTCARD_REQUIRED                      = &h40000 'flag SmartCard requerido
Const ADS_UF_TRUSTED_FOR_DELEGATION                  = &h80000 'flag confiado para delegação
Const ADS_UF_NOT_DELEGATED                           = &h100000 'flag não delegado
Const ADS_UF_USE_DES_KEY_ONLY                        = &h200000 'flag somente chave
Const ADS_UF_DONT_REQUIRE_PREAUTH                    = &h400000 'flag não requer utenticação
Const ADS_UF_PASSWORD_EXPIRED                        = &h800000 'flag sen expirada
Const ADS_UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION  = &h1000000 'flag confiado para autenticar para delegação
Dim strPassword 'Novo password do user local
Dim strDescricao 'descrição da conta criada
Const HKEY_CLASSES_ROOT   = &H80000000 'caminho para o hive de registro de HKEY_CLASSES_ROOT
Const HKEY_CURRENT_USER   = &H80000001 'caminho para o hive de registro de HKEY_CURRENT_USER
Const HKEY_LOCAL_MACHINE  = &H80000002 'caminho para o hive de registro de HKEY_LOCAL_MACHINE
Const HKEY_USERS          = &H80000003 'caminho para o hive de registro de HKEY_USERS
Const REG_SZ              = 1 'número que identifica strings de registro
Const REG_EXPAND_SZ       = 2 'número que identifica strings expandidas de registro
Const REG_BINARY          = 3 'número que identifica binários de registro
Const REG_DWORD           = 4 'número que identifica DWORDS de registro
Const REG_MULTI_SZ        = 7 'número que identifica multi strings de registro
Const JOIN_DOMAIN = 1
Const ACCT_CREATE = 2
Const ACCT_DELETE = 4
Const WIN9X_UPGRADE = 16
Const DOMAIN_JOIN_IF_JOINED = 32
Const JOIN_UNSECURE = 64
Const MACHINE_PASSWORD_PASSED = 128
Const DEFERRED_SPN_SET = 256
Const INSTALL_INVOCATION = 262144
'========================================================================================================


'=============== Subs Ativos =================================
CriaSupervisor
CriaAdministrador
AtivaDNSAutomatico
ChamaPropriedadeNome
MsgBox "Fim do Script!" & vbCrLf & vbCrLf & "favor verificar se deu tudo certo ;)", vbOKOnly, "Automação Projeto Serede"
'=============================================================



'=============================================================
Sub AdicionaGrupos
End Sub
'=============================================================
Sub AlteraHostname 'Sub-rotina só funciona com o sistema fora do domínio
	strComputador = "."

	strTipo = InputBox("Insira o tipo do computador" & vbCrLf & vbCrLf & "'D' para desktop" & vbCrLf & "'L' para laptop","Automação Projeto Serede")

	strPatrimonio = InputBox("Insira os cinco últimos números da etiqueta de Patrimônio (etiqueta de TI)",,"Automação Projeto Serede") 
	
	Set objWMIService = GetObject("winmgmts:\\" & strComputador & "\root\cimv2")
	
	Set colComputadores = objWMIService.ExecQuery("Select * from Win32_ComputerSystem")
	
	For Each objComputador in colComputadores
		If strTipo = "D" Then
			strPrefixo = "DSKPSRD0"
		ElseIf strTipo = "L" Then
			strPrefixo = "LAPPSRD0"
		Else
			WScript.Echo "TIPO DIGITADO INCORRETAMENTE, FAVOR INSERIR A INFORMAÇÃO CORRETA"
			WScript.Quit
		End If
		objComputador.Rename(strPrefixo & strPatrimonio)
	Next
	WScript.Echo "AlteraHostname Feito!"
End Sub
'=================================================================================================
Sub AtivaDNSAutomatico 'Ativa a busca automática do DNS
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
Sub CriaAdministrador 'Cria o fake ADM, seta a senha, descrição e as flags necessárias
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
	
	Set objGrupo = GetObject("WinNT://" & strComputador & "/Usuários")
	For Each iteUsuario In objGrupo.Members
		If InStr(iteUsuario.adspath,strUsuarioNovo) > 0 Then
			objGrupo.Remove(iteUsuario.AdsPath)
		End If
	Next
	WScript.Echo "CriaAdministrador Feito!"
End Sub
'=================================================================================================
Sub CriaSupervisor 'Cria o usuário supervisor, seta a senha padrão e a descrição
	strUsuarioAntigo = "Administrador"
	strUsuarioNovo = "Supervisor"
	strSenha = "#SUPPORT13s123"
	strDescricao = "Conta interna para a administração do computador/domínio"
	
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
Function DiretorioDoScript 'Retorna o diretório do Script
	DiretorioDoScript = Replace(WScript.ScriptFullName,WScript.ScriptName,"")
End Function
'=================================================================================================
Sub InsereDominio
	strDomain = "oi.corp.net"
	strPassword = "Senha"
	strUser = "TCXXXXXX"
	 
	Set objNetwork = CreateObject("WScript.Network")
	strComputer = objNetwork.ComputerName
	 
	Set objComputer = GetObject("winmgmts:{impersonationLevel=Impersonate}!\\" & strComputer & "\root\cimv2:Win32_ComputerSystem.Name='" & strComputer & "'")
	 
	ReturnValue = objComputer.JoinDomainOrWorkGroup(strDomain, strPassword, strDomain & "\" & strUser, NULL, JOIN_DOMAIN + ACCT_CREATE)
		WScript.Echo "InsereDominio Feito!"
End Sub
'=================================================================================================
Sub InstalaCyberS 'Inicia a instalação do CyberS
	Set objWshShell = CreateObject("Wscript.Shell")
	objWshShell.Run DiretorioDoScript & "\CyberS\Install_Cybers.exe",1,True
	WScript.Echo "InstalaCyberS Feito!"
End Sub
'=================================================================================================
Sub InstalaSCCM
	Set objWshShell = CreateObject("Wscript.Shell")
	objWshShell.Run DiretorioDoScript & "\SystemCenterConfigurationManager\ccmsetup.exe /mp:scmpw08.oi.corp.net SMSSITECODE=DCM DNSSUFFIX=oi.corp.net FSP=scmpw08.oi.corp.net /BITSPriority:HIGH",1,True
	WScript.Echo "InstalaSCCM Feito!"
End Sub
'=================================================================================================
Sub InstalaSEP32 'Inicia a instalação do SEP 32 bits
	Set objWshShell = CreateObject("Wscript.Shell")
	objWshShell.Run DiretorioDoScript & "\SymantecEndpointProtecton_32\Sep.msi /qb! /l*v " & Chr(34) & DiretorioDoScript & "\SEP_INST.LOG" & Chr(34),1,True
	WScript.Echo "InstalaSEP Feito!"
End Sub
'=================================================================================================
Sub InstalaSEP64 'Inicia a instalação do SEP 64 bits
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