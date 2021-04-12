:::::::::::::::::::::::::: Windows Project Manager ::::::::::::::::::::::::::::

:: 							                                                 ::
:: 						     ~ Author:- Fuad Hy                              ::
:: 					                                                         ::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off

setlocal enableextensions enabledelayedexpansion

if "%PROJECTS%"=="" (
	printf "Please add your projects path to system variables\041\n\nName: PROJECTS\nValue: your project path\n"
	goto :eof
)
set PROJDIR=%PROJECTS%
set SUBLIME="C:\Program Files\Sublime Text 3\subl.exe"
set CMD=%SystemRoot%\System32\cmd.exe
set drive=%PROJDIR:~0,1%
set explorer=%windir%\explorer.exe
cd %PROJDIR% && %drive%:

goto :main

:get
for /D %%f in (*) do (
	set text=!text!\n!c!: %%f
	set arr[!c!]=%%f
	set /A c += 1
)
set "%~1=%text%"
goto :eof

:inp
if "%~1"=="again" set p=You have to
set /P "cho=%p% Choose project: (q - exit) "
if "%cho%"=="q" (
	EXIT /b 1
)
if "%cho%"=="" (
	CALL :inp again
)
set /A val=%cho%
set /A validate="%2-%val%"

if %validate% GEQ %2 (
	echo Invalid choice
	CALL :inp again %2
) else if %validate% LEQ 0 (
	echo Invalid choice
	CALL :inp again %2
)
goto :eof

:main
cls
title Project Manager ('_')
setlocal
set /A c = 1
set text=
CALL :get dirs
printf "\n\t\t\tMy Projects%dirs%\n\n"
CALL :inp first %c%
if %errorlevel%==1 goto :eof
set PROJECT=!arr[%cho%]!
printf "\n1: VS Code\n2: Sublime text 3\n\n"
:editor
set /P EDITOR="Choose Editor...1/2 for '!arr[%cho%]!' project: "
if "%EDITOR%"=="1" (
	echo starting project "!arr[%cho%]!" with VS Code...
	START %PROJECT%
	code -n "%PROJECT%"
	START %CMD% /k "cd /d %PROJECT%"
) else (
	if "%EDITOR%"=="2" (
		echo starting project "!arr[%cho%]!" with Sublime text...
		START %PROJECT%
		START "starting project..." %SUBLIME% "%PROJECT%"
		START %CMD% /k "cd /d %PROJECT%"
	) else (
		echo Please choose between 1 and 2
		goto :editor
	)
)
endlocal
goto :main