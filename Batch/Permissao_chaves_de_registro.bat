@ECHO OFF
color 17
title Autorizador de Chaves por Diego Rosario Sousa
ECHO ########################################################################
ECHO #                                                                      #
ECHO #                  AUTORIZADOR DE CHAVES DE REGISTRO                   #
ECHO #                              N3 - SONDA                              #
ECHO #                                                                      #
ECHO ########################################################################
ECHO.
ECHO.
SET /P PERMISSAO=DIGITE O CAMINHO DA CHAVE QUE RECEBERA A PERMISSAO:
ECHO.
ECHO OBS.: LEMBRE-SE QUE A PERMISSAO SERA REPLICADA PARA AS SUBCHAVES DE:
ECHO.
ECHO %PERMISSAO%
:INICIO
SET /P CONTINUAR=DESEJA CONTINUAR?(S/N)

GOTO %CONTINUAR%

IF %CONTINUAR% == S (
GOTO %CONTINUAR%
)
IF %CONTINUAR% == N (
GOTO %CONTINUAR%
)
CLS
ECHO.
ECHO.
ECHO OPCAO INCORRETA
ECHO.
ECHO.
GOTO INICIO
:S
MD %temp%\Permissao_Chaves
ECHO %PERMISSAO% >>%temp%\Permissao_Chaves\Pesquisa_de_chaves.txt
REG QUERY %PERMISSAO% /k /f * /s >>%temp%\Permissao_Chaves\Pesquisa_de_chaves.txt
CD %temp%\Permissao_Chaves >nul
FOR /F "eol=F delims=#" %%p IN (Pesquisa_de_chaves.txt) DO ECHO %%p [1 5 7 17] >>regini_chaves.txt
REGINI regini_chaves.txt
CD..
RMDIR /S /Q Permissao_Chaves >nul

:N
ECHO.
ECHO.
ECHO ############################
ECHO ##                        ##
ECHO ## CONFIGURACAO TERMINADA ##
ECHO ##                        ##
ECHO ############################
ECHO.
pause >nul
