@ECHO OFF
::Escrita por Diego R.Sousa
::diegorosariosousa@gmail.com
TITLE REMOVE KB!!!
COLOR F0
SETLOCAL ENABLEDELAYEDEXPANSION
SET _batchPath=%~dp0
CD /D %_batchPath%
IF NOT EXIST "LISTA.TXT" (
	TYPE NUL >LISTA.TXT
	ECHO.
	ECHO ====================================================
	ECHO        O ARQUIVO "LISTA.TXT" FOI CRIADO;
	ECHO.
	ECHO        FAVOR PREENCHER COM O NéMERO DOS KB'S.
	ECHO.
	ECHO        SAINDO DA BATCH...
	ECHO ====================================================
	PING -n 8 127.0.0.1 >NUL
	START /d "C:\Windows\System32" /B NOTEPAD.EXE "%_batchPath%LISTA.TXT"
	EXIT
)
FINDSTR "." LISTA.TXT >NUL
IF NOT "%ERRORLEVEL%"=="0" (
	ECHO.
	ECHO ====================================================
	ECHO        O ARQUIVO "LISTA.TXT" NÇO PODE ESTAR VAZIO;
	ECHO.
	ECHO        FAVOR PREENCHER COM O NéMERO DOS KB'S.
	ECHO.
	ECHO        SAINDO DA BATCH...
	ECHO ====================================================
	PING -n 8 127.0.0.1 >NUL
	START /d "C:\Windows\System32" /B NOTEPAD.EXE "%_batchPath%LISTA.TXT"
	EXIT
)
IF EXIST "Resultado.evtx" (
	DEL /Q "Resultado.evtx"
)
IF EXIST "Resultado.evtx.dpx" (
	DEL /Q "Resultado.evtx.dpx"
)
ECHO ====================================================
FOR /F "DELIMS=" %%A IN (LISTA.TXT) DO (
	ECHO        REMOVENDO O KB %%A...
	START /D "C:\Windows\System32" /WAIT wusa /uninstall /kb:%%A /quiet /norestart /log:%_batchPath%Resultado.evtx
	ECHO ====================================================
)
ECHO        ABRINDO O ARQUIVO DE LOG...
ECHO ====================================================
PING -n 8 127.0.0.127 >NUL
START /d "C:\Windows\System32" /B EVENTVWR.EXE /l:"%_batchPath%Resultado.evtx"
ENDLOCAL
EXIT /Q
