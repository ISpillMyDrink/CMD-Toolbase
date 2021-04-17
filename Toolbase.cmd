@echo off
setlocal EnableDelayedExpansion

set modules=%~dp0Modules
set config=%~dp0Config
set tools=%~dp0Tools
set params=
set windowTitle=Toolbase
set submodulesPerLine=2
set charactersPerSubmodule=30
set requireAdmin=0
set startSelection=

cd /d %~dp0

for /f "delims=" %%a in (%~n0.cfg) do set "%%a"

set emptyLine=
for /l %%i in (1,1,%charactersPerSubmodule%) do set emptyLine=!emptyLine! 

title %windowTitle%

net file 1>nul 2>nul
if %errorlevel% NEQ 0 (
    if %requireAdmin% EQU 1 (
        echo The program has to be run as administrator.
        echo:
        pause
        exit /b
    )
)

for %%s in (%startSelection%) do set selected[%%s]=1

:menu
cls
call :displayModules
echo. X Quit      R Reboot      G Go      +/- None/All
echo:
set instructions=
set /p instructions=Please select modules to run: 
if /i "%instructions%" EQU "G" (
    call :executeModules
    pause
    goto menu
) else if /i "%instructions%" EQU "X" (
    exit /b
) else if /i "%instructions%" EQU "R" (
    shutdown /t 0 /r
) else if "%instructions%" EQU "+" (
    for /L %%s in (1,1,%numMod%) do set selected[%%s]=1
) else if "%instructions%" EQU "-" (
    for /L %%s in (1,1,%numMod%) do set selected[%%s]=0
)

for %%s in (%instructions%) do (
    if not defined selected[%%s] set selected[%%s]=0
    if !selected[%%s]! EQU 0 (
        set selected[%%s]=1
    ) else (
        set selected[%%s]=0
    )
)

goto menu


:displayModules
set numMod=0
for /f %%g in ('dir /ad /b "%modules%"') do (
    set catName=%%g
    set catName=!catName:~+4!
    set catName=!catName:_= !
    echo !catName!
    call :displaySubmodules "%modules%\%%g"
    echo:
    echo:
)
exit /b

:displaySubmodules
set line[0]=
set line[1]=
set numSub=0
for /R "%~1" %%a in (*.cmd) do (
    set /a numMod=!numMod!+1
    set /a numSub=!numSub!+1
    set dispNr=0!numMod!
    set dispNr=!dispNr:~-2!
    set dispName=%%~na
    set dispName=!dispName:~+4!
    set dispName=!dispName:_= !
    for /l %%i in (!numMod!,1,!numMod!) do set isSelected=!selected[%%i]!
    if !isSelected! EQU 1 (
        set dispNr=[!dispNr!]
    ) else (
        set dispNr= !dispNr! 
    )
    set /a r=!numSub! %% %submodulesPerLine%
    set line=!dispNr! !dispName!!emptyLine!
    "%tools%\echo.exe" -n "!line:~0,%charactersPerSubmodule%!"
    if !r! EQU 0 echo:
)
if !r! NEQ 0 echo:
exit /b

:executeModules
set numMod=0
for /R "%modules%" %%a in (*.cmd) do (
    set /a numMod=!numMod!+1
    for /l %%i in (!numMod!,1,!numMod!) do set isSelected=!selected[%%i]!
    if !isSelected! EQU 1 (
        echo %%~na running...
        call "%%a" "%config%" "%tools%" "%params%"
        echo %%~na done.
    )
)
exit /b