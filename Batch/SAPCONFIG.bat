@ECHO OFF
TITLE CONFIGURAÇÃO DO SAP N3
::CONFIGURAÇÃO DO SAP
::diegos.sonda@contratada.oi.net.br
SET _batchpath=%~dp0
:INICIO

	IF EXIST "%USERPROFILE%\AppData\Roaming\SAP\Common" (
		MD "%USERPROFILE%\AppData\Roaming\SAP\Common"
		SET _sapPath="%USERPROFILE%\AppData\Roaming\SAP\Common"
	)

:CONFIGURASAP
	COPY "%_batchpath%saplogon.ini" "%_sapPath%"
		IF NOT EXIST "%_sapPath%\saplogon.ini" (
			SET _valErro="%_sapPath%\saplogon.ini"
			GOTO ERRO1
		)
	COPY "%_batchpath%SapLogonTree.xml" "%_sapPath%"
		IF NOT EXIST "%_sapPath%\SapLogonTree.xml" (
			SET _valErro="%_sapPath%\SapLogonTree.xml"
			GOTO ERRO1
		)
	COPY "%_batchpath%saprules.xml" "%_sapPath%"
		IF NOT EXIST "%_sapPath%\saprules.xml" (
			SET _valErro="%_sapPath%\saprules.xml"
			GOTO ERRO1
		)
	COPY "%_batchpath%SAPUILandscape.xml" "%_sapPath%"
		IF NOT EXIST "%_sapPath%\SAPUILandscape.xml" (
			SET _valErro="%_sapPath%\SAPUILandscape.xml"
			GOTO ERRO1
		)
	COPY "%_batchpath%SAPUILandscapeGlobal.xml" "%_sapPath%"
		IF NOT EXIST "%_sapPath%\SAPUILandscapeGlobal.xml" (
			SET _valErro="%_sapPath%\SAPUILandscapeGlobal.xml"
			GOTO ERRO1
		)	
:DEFINE_NOME_SERVICES
	IF NOT EXIST "C:\Windows\System32\drivers\etc\services.old" (
		REN "C:\Windows\System32\drivers\etc\services" "C:\Windows\System32\drivers\etc\services.old"
		GOTO COPY_SERVICES
	)
	FOR /l %%A IN (1,1,100) DO (
		IF NOT EXIST "C:\Windows\System32\drivers\etc\services.old.%%A" (
			REN "C:\Windows\System32\drivers\etc\services" "C:\Windows\System32\drivers\etc\services.old.%%A"
			GOTO COPY_SERVICES
		)
	)
:COPY_SERVICES
	COPY "services" "C:\Windows\System32\drivers\etc"
	
	
	
	
	
	
	
	
	
	
	
	
	