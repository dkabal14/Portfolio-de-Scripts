@ECHO OFF
color 17
title Registrador de DLL's por Diego Rosario Sousa
ECHO ########################################################################
ECHO #                                                                      #
ECHO #                         REGISTRADOR DE DLL'S                         #
ECHO #                              N3 - SONDA                              #
ECHO #                                                                      #
ECHO ########################################################################
ECHO ##### PROCESSO INICIOU EM [%TIME%][%DATE%] ##### >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
IF NOT EXIST "%TEMP%\REGISTRADOR" MD "%TEMP%\REGISTRADOR" >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
ECHO. >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
ECHO. >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
%SYSTEMDRIVE% >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
SET PATH=%SYSTEMDRIVE%\Windows\System32;%~dp0;%PATH% >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
ECHO. >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
FOR /F "Delims=" %%v IN ('DialogBox.exe -msg "INFORME O DIRETORIO" -title  "Registrador de DLL's por Diego Rosario Sousa" -dir') DO SET DIRETORIO=%%v
ECHO [%TIME%][%DATE%] DIRETORIO INFORMADO PELO USUARIO FOI: %DIRETORIO% >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
DIalogBox.exe -msg "Voce tem certeza? Todas as DLL do diretorio %DIRETORIO% e subdiretorios serao registradas" -title Confirmacao -confirm


IF /I %ERRORLEVEL% equ 0 (
	ECHO [%TIME%][%DATE%] USUARIO ACEITOU A CONFIGURACAO >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
	GOTO REGISTRADOR
	) ELSE (
	ECHO [%TIME%][%DATE%] USUARIO RECUSOU A CONFIGURACAO >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
	GOTO ERRO
	)
:REGISTRADOR
ECHO [%TIME%][%DATE%] ENTRANDO EM %DIRETORIO% >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
CD "%DIRETORIO%" >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
DEL DLL.TXT
DIR /S /B *.DLL *.OCX >>DLL.TXT
ECHO [%TIME%][%DATE%] ##### FORAM ENCONTRADAS AS SEGUINTES DLL ##### >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
FOR /F "DELIMS=" %%i IN ('TYPE DLL.TXT') DO ECHO [%TIME%][%DATE%].......%%i >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
FOR /F "DELIMS=" %%r IN (DLL.TXT) DO REGSVR32 "%%r" /S&ECHO [%TIME%][%DATE%] "%%r" >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG

:ERRO
DIalogBox.exe -msg "FIM DO PROCESSO!	PROCURE O ARQUIVO DE LOG EM %TEMP%\REGISTRADOR\REGISTRADOR.LOG" -title "Registrador de DLL's por Diego Rosario Sousa" -info
ECHO ##### PROCESSO TERMINOU EM [%TIME%][%DATE%] ##### >>%TEMP%\REGISTRADOR\REGISTRADOR.LOG
EXIT
