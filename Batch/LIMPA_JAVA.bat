@ECHO OFF
ECHO LIMPANDO O JAVA
CD\
FOR /F "DELIMS=" %%A IN ('DIR /S /B Sun') DO RMDIR /S /Q "%%A"