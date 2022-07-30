set BatchPath=%~dp0
secedit /configure /db C:\windows\security\Database\secdb-Clarify.sdb /cfg %BatchPath%Clarify.inf /overwrite
gpedit.msc
pause