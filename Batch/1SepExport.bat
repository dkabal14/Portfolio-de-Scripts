@ECHO OFF
TITLE Export SEP Regs - Suporte Nível 3 RJ - Sonda IT
::BATCH escrita por Diego Rosário Sousa
CHOICE /C SN /M "A BATCH ALTERA CHAVES DE REGISTRO, DESEJA REALMENTE CONTINUAR"
SET BATCHPATH = %~dp0
MD "%BATCHPATH%SEP_REG_BACKUP"
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" "%BATCHPATH%SEP_REG_BACKUP\CurrentControlSet_SessionManager.reg"
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager" %BATCHPATH%SEP_REG_BACKUP\ControlSet001_SessionManager.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Session Manager" %BATCHPATH%SEP_REG_BACKUP\ControlSet002_SessionManager.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\Session Manager" %BATCHPATH%SEP_REG_BACKUP\ControlSet003_SessionManager.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\" %BATCHPATH%SEP_REG_BACKUP\WindowsUpdate_Auto-Update.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\KeysNotToRestore" %BATCHPATH%SEP_REG_BACKUP\CurrentControlSet_KeysNotToRestore.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\BackupRestore\KeysNotToRestore" %BATCHPATH%SEP_REG_BACKUP\ControlSet001_KeysNotToRestore.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\BackupRestore\KeysNotToRestore" %BATCHPATH%SEP_REG_BACKUP\ControlSet002_KeysNotToRestore.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\BackupRestore\KeysNotToRestore" %BATCHPATH%SEP_REG_BACKUP\ControlSet003_KeysNotToRestore.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SOFTWARE\Symantec_Installer" %BATCHPATH%SEP_REG_BACKUP\Symantec_Installer.reg
REG EXPORT "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Symantec_Installer" %BATCHPATH%SEP_REG_BACKUP\Symantec_Installer_x64.reg
CLS
ECHO.
ECHO.
ECHO TENTANDO DELETAR O VALOR "PendingFileRenameOperations" DE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager
ECHO TENTANDO DELETAR O VALOR "PendingFileRenameOperations" DE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /v "PendingFileRenameOperations" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /v "PendingFileRenameOperations"
	ECHO %TIME% - %DATE% PendingFileRenameOperations DELETEDA DE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) PendingFileRenameOperations NAO ENCONTRADA EM "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" >%BATCHPATH%SepExport.log
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR O VALOR "PendingFileRenameOperations" DE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager"
ECHO TENTANDO DELETAR O VALOR "PendingFileRenameOperations" DE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager" /v "PendingFileRenameOperations" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager" /v "PendingFileRenameOperations"
	ECHO %TIME% - %DATE% VALOR DELETADO: "PendingFileRenameOperations" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) VALOR NAO ENCONTRADO: "PendingFileRenameOperations" >%BATCHPATH%SepExport.log
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR O VALOR "PendingFileRenameOperations" DE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Session Manager"
ECHO TENTANDO DELETAR O VALOR "PendingFileRenameOperations" DE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Session Manager" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Session Manager" /v "PendingFileRenameOperations" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Session Manager" /v "PendingFileRenameOperations"
	ECHO %TIME% - %DATE% VALOR DELETADO: "PendingFileRenameOperations" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) VALOR NAO ENCONTRADO: "PendingFileRenameOperations" >%BATCHPATH%SepExport.log
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR O VALOR "PendingFileRenameOperations" DE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\Session Manager"
ECHO TENTANDO DELETAR O VALOR "PendingFileRenameOperations" DE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\Session Manager" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\Session Manager" /v "PendingFileRenameOperations" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\Session Manager" /v "PendingFileRenameOperations"
	ECHO %TIME% - %DATE% VALOR DELETADO: "PendingFileRenameOperations" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) VALOR NAO ENCONTRADO: "PendingFileRenameOperations" >%BATCHPATH%SepExport.log
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR A CHAVE "RebootRequired" de "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update"
ECHO TENTANDO DELETAR A CHAVE "RebootRequired" de "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
	ECHO %TIME% - %DATE% CHAVE DELETADA: "RebootRequired" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) CHAVE NAO ENCONTRADA: "RebootRequired >%BATCHPATH%SepExport.log"
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR A CHAVE "KeysNotToRestore" de "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BackupRestore"
ECHO TENTANDO DELETAR A CHAVE "KeysNotToRestore" de "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BackupRestore" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BackupRestore" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BackupRestore"
	ECHO %TIME% - %DATE% CHAVE DELETADA: "KeysNotToRestore" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) CHAVE NAO ENCONTRADA: "KeysNotToRestore" >%BATCHPATH%SepExport.log"
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR A CHAVE "KeysNotToRestore" de "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\BackupRestore"
ECHO TENTANDO DELETAR A CHAVE "KeysNotToRestore" de "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\BackupRestore" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\BackupRestore\KeysNotToRestore" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\BackupRestore\KeysNotToRestore"
	ECHO %TIME% - %DATE% CHAVE DELETADA: "KeysNotToRestore" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) CHAVE NAO ENCONTRADA: "KeysNotToRestore" >%BATCHPATH%SepExport.log"
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR A CHAVE "KeysNotToRestore" de "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\BackupRestore"
ECHO TENTANDO DELETAR A CHAVE "KeysNotToRestore" de "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\BackupRestore" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\BackupRestore\KeysNotToRestore" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\BackupRestore\KeysNotToRestore"
	ECHO %TIME% - %DATE% CHAVE DELETADA: "KeysNotToRestore" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) CHAVE NAO ENCONTRADA: "KeysNotToRestore" >%BATCHPATH%SepExport.log"
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR A CHAVE "KeysNotToRestore" de "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\BackupRestore"
ECHO TENTANDO DELETAR A CHAVE "KeysNotToRestore" de "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\BackupRestore" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\BackupRestore\KeysNotToRestore" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\BackupRestore\KeysNotToRestore"
	ECHO %TIME% - %DATE% CHAVE DELETADA: "KeysNotToRestore" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) CHAVE NAO ENCONTRADA: "KeysNotToRestore" >%BATCHPATH%SepExport.log"
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR A CHAVE "Symantec_Installer" de "HKEY_LOCAL_MACHINE\SOFTWARE"
ECHO TENTANDO DELETAR A CHAVE "Symantec_Installer" de "HKEY_LOCAL_MACHINE\SOFTWARE" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Symantec_Installer" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Symantec_Installer"
	ECHO %TIME% - %DATE% CHAVE DELETADA: "Symantec_Installer" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) CHAVE NAO ENCONTRADA: "Symantec_Installer" >%BATCHPATH%SepExport.log"
)
PING -n 5 localhost >NUL
ECHO TENTANDO DELETAR A CHAVE "Symantec_Installer" de "HKEY_LOCAL_MACHINE\SOFTWARE"
ECHO TENTANDO DELETAR A CHAVE "Symantec_Installer" de "HKEY_LOCAL_MACHINE\SOFTWARE" >%BATCHPATH%SepExport.log
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Symantec_Installer" >NUL
IF "%ERRORLEVEL%"=="0" (
	REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Symantec_Installer"
	ECHO %TIME% - %DATE% CHAVE DELETADA: "Symantec_Installer" >%BATCHPATH%SepExport.log
) ELSE (
	ECHO %TIME% - %DATE% (WARNING) CHAVE NAO ENCONTRADA: "Symantec_Installer" >%BATCHPATH%SepExport.log"
)
PING -n 5 localhost >NUL
CLS
ECHO ABRINDO O ARQUIVO DE LOG
NOTEPAD %BATCHPATH%SepExport.log