@echo off
color 0a
title SCRIPT DE CORRECAO DO FPW N3-RJ
echo ------------------------------------------------- >> %%0\..\FPW.log
echo ##### INICIO DA LOG [%date%] [%time%] ##### >> %%0\..\FPW.log
echo ------------------------------------------------- >> %%0\..\FPW.log
Rem #### editado em 06/11/2014  N3 RJ
echo -------------------------------------------------
Echo *********************************************************
Echo *********************************************************
Echo ***         Correção da Atualização do FPW            ***
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ping localhost -n 7 >nul
cls
Rem ########################inicio menu##############################
FOR /F %%V IN ('DialogBox.exe -Title "SCRIPT DE CORRECAO DO FPW N3-RJ" -msg "INICIANDO O FPW POR FAVOR ESCOLHA O SISTEMA E AGUARDE!" -choice -item "SISTEMA DE 32BITS" -item "SISTEMA DE 64BITS"') DO SET op=%%V
ECHO %op% >> %%0\..\FPW.log
if %op%=="SISTEMA DE 32BITS" (goto 32bits)
if %op%=="SISTEMA DE 64BITS" (goto 64bits)
Rem ########################fim menu#############################
cls
Rem ########################inicio 32bits##############################
:32bits
echo ----------------------------------------------
echo PARANDO PROCESSO FPW
echo ----------------------------------------------
echo PARANDO PROCESSO FPW %date% %time% >> %%0\..\FPW.log
Rem para o processo fpw.exe está rodando:
start /wait taskkill /F /IM FPw5.exe /T >> %%0\..\FPW.log
start /wait taskkill /F /IM FPw_UpdateClient.exe /T >> %%0\..\FPW.log
ping localhost -n 5 >nul
cls
echo ----------------------------------------------
echo PARANDO SERVICO MSDTC
echo ----------------------------------------------
echo PARANDO SERVICO MSDTC %date% %time% >> %%0\..\FPW.log
Rem para o serviço msdtc
start /wait net stop msdtc >> %%0\..\FPW.log
ping localhost -n 5 >nul
cls
echo ----------------------------------------------
echo PARANDO O SERVICO SYSTEM APPLICATION
echo ----------------------------------------------
echo PARANDO O SERVICO SYSTEM APPLICATION %date% %time% >> %%0\..\FPW.log
Rem parar o serviço COM + System Application
start /wait net stop COMSysApp  >> %%0\..\FPW.log
ping localhost -n 5 >nul
cls
echo ----------------------------------------------
ECHO DESINSTALANDO MSDTC
echo ----------------------------------------------
ECHO DESINSTALANDO MSDTC %date% %time% >> %%0\..\FPW.log
Rem executar o comando
start /wait %WINDIR%\System32\msdtc.exe -uninstall >> %%0\..\FPW.log
ping localhost -n 30 >nul
cls
echo ----------------------------------------------
ECHO REMOVENDO ARQUIVOS DE REGISTRO
echo ----------------------------------------------
ECHO REMOVENDO ARQUIVOS DE REGISTRO %date% %time% >> %%0\..\FPW.log
start /wait REG DELETE HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSDTC /f >> %%0\..\FPW.log
ping localhost -n 2 >nul
start /wait REG DELETE HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MSDTC /f >> %%0\..\FPW.log
ping localhost -n 2 >nul
start /wait REG DELETE HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\MSDTC /f >> %%0\..\FPW.log
ping localhost -n 2 >nul
start /wait REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC /f >> %%0\..\FPW.log
ping localhost -n 3 >nul
cls
echo ----------------------------------------------
ECHO INSTALANDO MSDTC
echo ----------------------------------------------
ECHO INSTALANDO MSDTC %date% %time% >> %%0\..\FPW.log
Rem executar o comando
start /wait %WINDIR%\System32\msdtc.exe -install >> %%0\..\FPW.log
ping localhost -n 60 >nul
cls
::echo ----------------------------------------------
::ECHO COPIANDO COMPONENTE ANTIGO 
::echo ----------------------------------------------
::ECHO COPIANDO COMPONENTE ANTIGO %date% %time% >> %%0\..\FPW.log
Rem copia o componente complus
::start /wait XCOPY "\\fpwpw03\Clients\FPW5_MTS.msi" "c:\" /y >> %%0\..\FPW.log
::ping localhost -n 7 >nul
::cls
::echo ----------------------------------------------
::echo REMOVENDO COMPONENTE ANTIGO DO FPW
::echo ----------------------------------------------
::echo REMOVENDO COMPONENTE ANTIGO DO FPW %date% %time% >> c:\FPW.txt
::Rem remover o componente
rem http://technet.microsoft.com/pt-br/library/cc731937(v=ws.10).aspx
::start /wait msiexec /uninstall c:\FPW5_MTS.msi
::ping localhost -n 10 >nul
::del C:\FPW5_MTS.msi /q
::cls
::echo ----------------------------------------------
::ECHO INSTALANDO O NOVO COMPONENTE FPW
::echo ----------------------------------------------
::ECHO INSTALANDO O NOVO COMPONENTE FPW %date% %time% >> c:\FPW.txt
REM COPIANDO NOVO COMPONENTE PARA C:\
::start /wait XCOPY "\\fpwpw03\Clients\FPW5_MTS.msi" "c:\" /y >> c:\FPW.txt
::ping localhost -n 15 >nul
Rem #instalar o componente
rem http://technet.microsoft.com/pt-br/library/cc754409(v=ws.10).aspx
::start /wait msiexec -i c:\FPW5_MTS.msi
::ping localhost -n 5 >nul
::cls
REM ####
set load=
set/a loadnum=0
:Loading
set load=%load%X
cls
echo.
echo --------------------------------------------------------------------------------
echo REMOVENDO ARQUIVOS... aguarde...%load%
echo --------------------------------------------------------------------------------
ping localhost -n 2 >nul
set/a loadnum=%loadnum% +1
if %loadnum%==8 goto Done
goto Loading
:Done
::del C:\FPW5_MTS.msi /q
echo --------------------------------------------------------------------------------
echo INICIANDO O FPW POR FAVOR AGUARDE!
echo --------------------------------------------------------------------------------
start /wait taskkill /F /IM FPw5.exe /T >> %%0\..\FPW.log
IF EXIST "%programfiles%\LG Informatica\FPw\FPw5.exe" (
	START /WAIT "%programfiles%\LG Informatica\FPw\FPw5.exe"
	)
echo -=-=-=-=-=-=-=-=-=FIM-=-=-=-=-=-=-=-=-=
echo -=-=-=-=-=-=-=-=-=FIM-=-=-=-=-=-=-=-=-= >> %%0\..\FPW.log
COPY "%%0\..\FPW.log" "%TEMP%"
ping localhost -n 4 >nul
exit
Rem ########################fim 32bits##############################

Rem ########################inicio 64bits##############################
:64bits
echo ----------------------------------------------
echo PARANDO PROCESSO FPW
echo ----------------------------------------------
echo PARANDO PROCESSO FPW %date% %time% >> %%0\..\FPW.log
Rem para o processo fpw.exe está rodando:
start /wait taskkill /F /IM FPw5.exe /T >> %%0\..\FPW.log
start /wait taskkill /F /IM FPw_UpdateClient.exe /T >> %%0\..\FPW.log
ping localhost -n 5 >nul
cls
echo ----------------------------------------------
echo PARANDO SERVICO MSDTC
echo ----------------------------------------------
echo PARANDO SERVICO MSDTC %date% %time% >> %%0\..\FPW.log
Rem para o serviço msdtc
start /wait net stop msdtc >> c:\FPW.txt
ping localhost -n 5 >nul
cls
echo ----------------------------------------------
echo PARANDO O SERVICO SYSTEM APPLICATION
echo ----------------------------------------------
echo PARANDO O SERVICO SYSTEM APPLICATION %date% %time% >> %%0\..\FPW.log
Rem parar o serviço COM + System Application
start /wait net stop COMSysApp  >> c:\FPW.txt
ping localhost -n 5 >nul
cls
echo ----------------------------------------------
ECHO DESINSTALANDO MSDTC
echo ----------------------------------------------
ECHO DESINSTALANDO MSDTC %date% %time% >> %%0\..\FPW.log
Rem executar o comando
start /wait %WINDIR%\System32\msdtc.exe -uninstall >> %%0\..\FPW.log
ping localhost -n 30 >nul
cls
echo ----------------------------------------------
ECHO REMOVENDO ARQUIVOS DE REGISTRO
echo ----------------------------------------------
ECHO REMOVENDO ARQUIVOS DE REGISTRO %date% %time% >> %%0\..\FPW.log
start /wait REG DELETE HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSDTC /f >> %%0\..\FPW.log
ping localhost -n 2 >nul
start /wait REG DELETE HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MSDTC /f >> %%0\..\FPW.log
ping localhost -n 2 >nul
start /wait REG DELETE HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\MSDTC /f >> %%0\..\FPW.log
ping localhost -n 2 >nul
start /wait REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC /f >> %%0\..\FPW.log
ping localhost -n 3 >nul
cls
echo ----------------------------------------------
ECHO INSTALANDO MSDTC
echo ----------------------------------------------
ECHO INSTALANDO MSDTC %date% %time% >> %%0\..\FPW.log
Rem executar o comando
start /wait %WINDIR%\System32\msdtc.exe -install >> %%0\..\FPW.log
ping localhost -n 60 >nul
cls
echo ----------------------------------------------
ECHO MSDTC REPARADO REMOVA OS COMPONENTES DO FPW
echo ----------------------------------------------
ECHO MSDTC REPARADO REMOVA OS COMPONENTES DO FPW %date% %time% >> %%0\..\FPW.log
start dcomcnfg >> %%0\..\FPW.log
ping localhost -n 7 >nul
echo ----------------------------------------------
ECHO APOS TER REMOVIDO O COMPONENTE PRESSIONE ENTER
echo ---------------------------------------------- 
pause
cls
::echo ----------------------------------------------
::ECHO INSTALANDO O NOVO COMPONENTE FPW
::echo ----------------------------------------------
::ECHO INSTALANDO O NOVO COMPONENTE FPW %date% %time% >> c:\FPW.txt
::REM COPIANDO NOVO COMPONENTE PARA C:\
::start /wait XCOPY "\\fpwpw03\Clients\FPW5_MTS.msi" "c:\" /y >> c:\FPW.txt
::ping localhost -n 15 >nul
::Rem #instalar o componente
rem http://technet.microsoft.com/pt-br/library/cc754409(v=ws.10).aspx
::start /wait msiexec -i c:\FPW5_MTS.msi
::ping localhost -n 5 >nul
::cls
REM ####
set load=
set/a loadnum=0
:Loading
set load=%load%X
cls
echo.
echo --------------------------------------------------------------------------------
echo REMOVENDO ARQUIVOS... aguarde...%load% 
echo --------------------------------------------------------------------------------
ping localhost -n 2 >nul
set/a loadnum=%loadnum% +1
if %loadnum%==8 goto Done
goto Loading
:Done
del C:\FPW5_MTS.msi /q >> %%0\..\FPW.log
echo --------------------------------------------------------------------------------
echo INICIANDO O FPW POR FAVOR AGUARDE! 
echo --------------------------------------------------------------------------------
start /wait taskkill /F /IM FPw5.exe /T >> %%0\..\FPW.log
"%programfiles(x86)%\LG Informatica\FPw\FPw5.exe"
echo -=-=-=-=-=-=-=-=-=FIM-=-=-=-=-=-=-=-=-=
echo -=-=-=-=-=-=-=-=-=FIM-=-=-=-=-=-=-=-=-= >> %%0\..\FPW.log
COPY "%%0\..\FPW.log" "%TEMP%"
ping localhost -n 4 >nul
exit
Rem ########################fim 64bits##############################