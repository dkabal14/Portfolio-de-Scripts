@echo off
CLS

::Mata o processo da VPN

Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CARREGANDO

taskkill /im nsload.exe /f

::Mata o processo do receiver

CLS
Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CARREGANDO ллллллллллл

taskkill /im receiver.exe /f

::Altera a chave de registro responsсvel pela alteraчуo do эcone

CLS
Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CARREGANDO лллллллллллллллллллллл

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Citrix\Secure Access Client" /v DisableIconHide /t REG_DWORD /d 00000001 /f

::Mata o processo do exlorer

CLS
Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CARREGANDO ллллллллллллллллллллллллллллллллл

taskkill /im explorer.exe /f

::Reinicia o processo do explorer

CLS
Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CARREGANDO лллллллллллллллллллллллллллллллллллллллллллл

ping -n 3 127.0.0.1 >nul

start /d "%systemroot%" /b explorer.exe

CLS
Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CARREGANDO ллллллллллллллллллллллллллллллллллллллллллллллллллллллл

::Reinicia o Citrix receiver

::Inicia o receiver no Win 7 64

IF EXIST "C:\Program Files (x86)\Citrix\Receiver" (
start /d "C:\Program Files (x86)\Citrix\Receiver" Receiver.exe
)

::Inicia o receiver no XP

IF EXIST "C:\Arquivos de Programas\Citrix\Receiver" (
start /d "C:\Arquivos de Programas\Citrix\Receiver" Receiver.exe
)

::Inicia o receiver no Win 7 32

IF EXIST "C:\Program Files\Citrix\Receiver" (
start /d "C:\Program Files\Citrix\Receiver" Receiver.exe
)

CLS
Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CARREGANDO лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

::Inicia o Netscaler no Win 7 64

IF EXIST "C:\Program Files (X86)\Citrix\Secure Access Client" (
start /d "C:\Program Files (X86)\Citrix\Secure Access Client" nsload.exe
)

::Inicia o Netscaler no Win 7 32

IF EXIST "C:\Program Files\Citrix\Secure Access Client"
start /d "C:\Program Files\Citrix\Secure Access Client" nsload.exe
)

::Inicia o Netscaler no Win XP

IF EXIST "C:\Arquivos de Programas\Citrix\Secure Access Client" (
start /d "C:\Arquivos de Programas\Citrix\Secure Access Client" nsload.exe
)

:CONTINUE

CLS
Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CARREGANDO ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
PING -n 1 127.0.0.1 >nul

CLS
Echo *********************************************************
Echo *********************************************************
Echo ***                       Oi                          ***
Echo ***                Microinformatica                   ***
Echo *********************************************************
Echo *********************************************************
ECHO CONFIGURACAO TERMINADA
PAUSE

ping -n 3 127.0.0.1 >nul
EXIT
