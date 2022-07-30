SET _proxy="seu proxy"

REG DELETE "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v "AutoConfig" /f
REG DELETE "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v "Proxy" /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "AutoConfigProxy" /d %_proxy% /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\iphlpsvc\Parameters\ProxyMgr\{C79ABE5B-FEED-4292-86F8-F52786466EE4}" /v "AutoConfigURL" /t /d %_proxy% /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NlaSvc\Parameters\Internet\ManualProxies" /ve /d %_proxy% /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iphlpsvc\Parameters\ProxyMgr\{C79ABE5B-FEED-4292-86F8-F52786466EE4}" /v "AutoConfigUrl" /d %_proxy% /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\ManualProxies" /ve /d %_proxy% /f
FOR /F %%A IN ('REG QUERY HKEY_USERS /f S-1-5-21') DO (
    IF NOT %%A==Fim (
        REG ADD "%%A\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "AutoConfigURL" /d %_proxy% /f
    )
)
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "AutoConfigURL" /f
