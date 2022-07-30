@ECHO OFF
TITLE VOCE TEM DADO EM CASA? POR Diego Rosario Sousa
COLOR 07
:INICIO
FOR /F "delims=" %%v in ('DialogBox.exe -title "VOCE TEM DADO EM CASA? POR Diego Rosario Sousa" -msg "ESCOLHA O NUMERO DE LADOS DO DADO!!!" -choice -item 4 -item 6 -item 8 -item 10 -item 12 -item 20') do set escolha=%%v

CLS
IF %ESCOLHA% == 4 (
GOTO CONTINUE
)
IF %ESCOLHA% == 6 (
GOTO CONTINUE
)
IF %ESCOLHA% == 8 (
GOTO CONTINUE
)
IF %ESCOLHA% == 10 (
GOTO CONTINUE
)
IF %ESCOLHA% == 12 (
GOTO CONTINUE
)
IF %ESCOLHA% == 20 (
GOTO CONTINUE
) ELSE (
GOTO ERRO
)
:CONTINUE
GOTO DADO%ESCOLHA%

:DADO4
SET /A NUMDADO=%random% %% 5
IF %NUMDADO% == 0 (
GOTO DADO4
)
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO4

:DADO6
SET /A NUMDADO=%random% %% 6
ECHO DADO ROLANDO...
ECHO.
ECHO.
PING -n 1 127.0.0.1 >NUL

IF %NUMDADO% == 0 (
GOTO IMAGE1
)
IF %NUMDADO% == 1 (
GOTO IMAGE2
)
IF %NUMDADO% == 2 (
GOTO IMAGE3
)
IF %NUMDADO% == 3 (
GOTO IMAGE4
)
IF %NUMDADO% == 4 (
GOTO IMAGE5
)
IF %NUMDADO% == 5 (
GOTO IMAGE6
)
:IMAGE1
SET /A NUMDADO=%NUMDADO%+1
COLOR F0
ECHO                            +++++++++++++++++++++++++
ECHO                            +                       +
ECHO                            +                       +
ECHO                            +                       +
ECHO                            +                       +
ECHO                            +          @@           +
ECHO                            +         @@@@          +
ECHO                            +          @@           +
ECHO                            +                       +
ECHO                            +                       +
ECHO                            +                       +
ECHO                            +++++++++++++++++++++++++
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO6

:IMAGE2
SET /A NUMDADO=%NUMDADO%+1
COLOR 80
ECHO                            +++++++++++++++++++++++++
ECHO                            +                       +
ECHO                            +               @@      +
ECHO                            +              @@@@     +
ECHO                            +               @@      +
ECHO                            +                       +
ECHO                            +     @@                +
ECHO                            +    @@@@               +
ECHO                            +     @@                +
ECHO                            +                       +
ECHO                            +++++++++++++++++++++++++
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO6

:IMAGE3
SET /A NUMDADO=%NUMDADO%+1
COLOR 20
ECHO                            +++++++++++++++++++++++++
ECHO                            +                       +
ECHO                            +                 @@    +
ECHO                            +                @@@@   +
ECHO                            +          @@     @@    +
ECHO                            +         @@@@          +
ECHO                            +   @@     @@           +
ECHO                            +  @@@@                 +
ECHO                            +   @@                  +
ECHO                            +                       +
ECHO                            +++++++++++++++++++++++++
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO6

:IMAGE4
SET /A NUMDADO=%NUMDADO%+1
COLOR 17
ECHO                            +++++++++++++++++++++++++
ECHO                            +                       +
ECHO                            +     @@          @@    +
ECHO                            +    @@@@        @@@@   +
ECHO                            +     @@          @@    +
ECHO                            +                       +
ECHO                            +     @@          @@    +
ECHO                            +    @@@@        @@@@   +
ECHO                            +     @@          @@    +
ECHO                            +                       +
ECHO                            +++++++++++++++++++++++++
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO6

:IMAGE5
SET /A NUMDADO=%NUMDADO%+1
COLOR 60
ECHO                            +++++++++++++++++++++++++
ECHO                            +                       +
ECHO                            +   @@            @@    +
ECHO                            +  @@@@          @@@@   +
ECHO                            +   @@     @@     @@    +
ECHO                            +         @@@@          +
ECHO                            +   @@     @@     @@    +
ECHO                            +  @@@@          @@@@   +
ECHO                            +   @@            @@    +
ECHO                            +                       +
ECHO                            +++++++++++++++++++++++++
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO6

:IMAGE6
SET /A NUMDADO=%NUMDADO%+1
COLOR 47
ECHO                            +++++++++++++++++++++++++
ECHO                            +   @@            @@    +
ECHO                            +  @@@@          @@@@   +
ECHO                            +   @@            @@    +
ECHO                            +       @@    @@        +
ECHO                            +      @@@@  @@@@       +
ECHO                            +       @@    @@        +
ECHO                            +   @@            @@    +
ECHO                            +  @@@@          @@@@   +
ECHO                            +   @@            @@    +
ECHO                            +++++++++++++++++++++++++
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
ECHO                                 "!!!!CRITICO!!!!"
PAUSE >nul
CLS
GOTO DADO6

:DADO8
SET /A NUMDADO=%random% %% 9
IF %NUMDADO% == 0 (
GOTO DADO8
)
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO8

:DADO10
SET /A NUMDADO=%random% %% 11
IF %NUMDADO% == 0 (
GOTO DADO10
)
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO10

:DADO12
SET /A NUMDADO=%random% %% 13
IF %NUMDADO% == 0 (
GOTO DADO12
)
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO12

:DADO20
SET /A NUMDADO=%random% %% 21
IF %NUMDADO% == 0 (
GOTO DADO20
)
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ......................SEU DADO ROLOU, O RESULTADO FOI %NUMDADO%.......................
PAUSE >nul
CLS
GOTO DADO20

:ERRO
CLS
ECHO ESCOLHA INCORRETA
PAUSE
CLS
GOTO INICIO
