::@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
:INICIO
	FOR /F "DELIMS=" %%A IN ('DialogBox.exe -title "Armazenamento de Evidências SEP" -msg "Deseja ARMAZENAR, CONSULTAR ou EXPORTAR um registro?" -choice -item "ARMAZENAR" -item "CONSULTAR" -item "EXPORTAR"') DO (
		SET _escolha=%%A
	)
	IF DEFINED %_escolha% (
		GOTO %_escolha%
	) ELSE (
		EXIT /b
	)
	

:ARMAZENAR
	
	::Pega o evento envolvido
	FOR /F "DELIMS=" %%B IN ('DialogBox.exe -title "Armazenamento de Evidências SEP" -msg "Escolha os eventos envolvidos:" -choice -item "TOP_RISK" -item "NEW_RISK" -item "TOP_TARGET" -item "TOP_SOURCE" -item "SINGLE_RISK"') DO (
		SET _eventosEnvolvidos=%%B,!_eventosEnvolvidos!
	)
	IF NOT DEFINED %_eventosEnvolvidos% (
		EXIT /b
	)
	
	::Pega o nome do computador afetado
	FOR /F "DELIMS=" %%C IN ('DialogBox.exe -title "Armazenamento de Evidências SEP" -msg "Digite o HOSTNAME:" -input') DO (
		SET _computadorAfetado=%%C
	)
	IF NOT DEFINED %_computadorAfetado% (
		EXIT /b
	)
	
	::Tira a vírgula do final do evento
	SET _eventosEnvolvidos=%_eventosEnvolvidos:~0,-1%
	
	::Adiciona o evento utilizando um script PowerShell
	PowerShell .\Adiciona_Evidencia.ps1 -eventosenvolvidos %_eventosEnvolvidos% -computadorafetado %_computadorAfetado%
	SET _eventosEnvolvidos=
	SET _computadorAfetado=
	GOTO INICIO
	
:CONSULTAR
	
	FOR /F "DELIMS=" %%D IN ('DialogBox.exe -title "Armazenamento de Evidências SEP" -msg "Escolha o tipo da consulta:" -choice -item "HostName" -item "Data" -item "Hora" -item "Evento"') DO (
		SET _tipoConsulta=%%D
	)
	GOTO %_tipoConsulta%
	
	:HostName
		
		FOR /F "DELIMS=" %%E IN ('DialogBox.exe -title "Armazenamento de Evidências SEP" -msg "Digite o nome do computador:" -input') DO (
			SET _computadorAfetado=%%E
		)
		
	)
		
	:Data
		
	:Hora
		
	:Evento
		
:EXPORTAR