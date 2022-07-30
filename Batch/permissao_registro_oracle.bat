@ECHO OFF
color 17
Title Permissao Oracle por Diego Rosario Sousa

ECHO .
ECHO ########################################################################
ECHO #                                                                      #
ECHO #                          PERMISSOES DO ORACLE                        #
ECHO #                               N3 - SONDA                             #
ECHO #                                                                      #
ECHO ########################################################################
ECHO.

MD %temp%\Permissao_Oracle >nul
ECHO HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Oracle >>%temp%\Permissao_Oracle\Pesquisa_de_chaves.txt
REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Oracle /k /f * /s >>%temp%\Permissao_Oracle\Pesquisa_de_chaves.txt
ECHO HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment >>%temp%\Permissao_Oracle\Pesquisa_de_chaves.txt
CD %temp%\Permissao_Oracle >nul
FOR /F "eol=F delims=#" %%p IN (Pesquisa_de_chaves.txt) DO ECHO %%p [1 5 7 17] >>regini_chaves.txt
REGINI regini_chaves.txt
CD..
PAUSE
RMDIR /S /Q Permissao_Oracle >nul

ECHO.
ECHO #####################
ECHO Configuracao Conluida
ECHO #####################
ECHO.
Pause
