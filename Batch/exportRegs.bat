reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" %windir%\PendingFileRenameOperations.reg
reg export "HKLM\SYSTEM\ControlSet001\Control\Session Manager" %windir%\PendingFileRenameOperations001.reg
reg export "HKLM\SYSTEM\ControlSet002\Control\Session Manager" %windir%\PendingFileRenameOperations002.reg
reg export "HKLM\SYSTEM\ControlSet003\Control\Session Manager" %windir%\PendingFileRenameOperations003.reg
reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" %windir%\RebootRequired.reg

REG DELETE "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f
REG DELETE "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v PendingFileRenameOperations /f
REG DELETE "HKLM\SYSTEM\ControlSet002\Control\Session Manager" /v PendingFileRenameOperations /f
REG DELETE "HKLM\SYSTEM\ControlSet003\Control\Session Manager" /v PendingFileRenameOperations /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" 