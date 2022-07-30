::Escrito por Diego - Suporte nível 3 - rj
SET BP=%~dp0
CD /D %BP%
FOR /F "DELIMS=" %%I IN (MudaRegistro.TXT) DO (
	SC \\%%I CONFIG RemoteRegistry Start=auto
	PING -n 5 >nul
	SC \\%%I START RemoteRegistry
	PING -n 5 >nul
	REG ADD \\%%I\HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters\ /v AllowEncryptionOracle /t REG_DWORD /d 2 /f
)