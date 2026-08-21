@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem ============================================================
rem Generic Autodesk ODIS installation template
rem Confirm the installer mechanism and supported command first.
rem ============================================================

set "PRODUCTNAME=CHANGE_ME"
set "PROCESSNAME=CHANGE_ME.exe"
set "VERIFYEXE=%ProgramFiles%\Autodesk\CHANGE_ME\CHANGE_ME.exe"
set "INSTALLARGS=CHANGE_ME"
set "SOURCE=%~dp0Media"
set "LOGDIR=%ProgramData%\Autodesk\Logs"
set "LOGFILE=%LOGDIR%\Generic_Autodesk_Install.log"

if not exist "%LOGDIR%" md "%LOGDIR%" 2>nul

>"%LOGFILE%" echo =====================================================
>>"%LOGFILE%" echo Product: %PRODUCTNAME%
>>"%LOGFILE%" echo Started: %DATE% %TIME%
>>"%LOGFILE%" echo Source: %SOURCE%
>>"%LOGFILE%" echo =====================================================

fltmc >nul 2>&1
if errorlevel 1 (
    echo ERROR: Run this script as Administrator.
    >>"%LOGFILE%" echo ERROR: Administrator privileges are required.
    exit /b 100
)

if not exist "%SOURCE%\Setup.exe" (
    echo ERROR: Setup.exe was not found.
    >>"%LOGFILE%" echo ERROR: Missing "%SOURCE%\Setup.exe"
    exit /b 101
)

if not exist "%SOURCE%\setup.xml" (
    echo ERROR: setup.xml was not found.
    >>"%LOGFILE%" echo ERROR: Missing "%SOURCE%\setup.xml"
    exit /b 102
)

if /I "%PRODUCTNAME%"=="CHANGE_ME" (
    echo ERROR: Configure the product variables before use.
    >>"%LOGFILE%" echo ERROR: Template variables are unchanged.
    exit /b 110
)

if /I "%INSTALLARGS%"=="CHANGE_ME" (
    echo ERROR: Confirm and configure the supported install arguments.
    >>"%LOGFILE%" echo ERROR: INSTALLARGS is unchanged.
    exit /b 111
)

tasklist /FI "IMAGENAME eq %PROCESSNAME%" /NH 2>nul | find /I "%PROCESSNAME%" >nul
if not errorlevel 1 (
    echo ERROR: %PRODUCTNAME% is currently running.
    >>"%LOGFILE%" echo ERROR: %PROCESSNAME% is currently running.
    exit /b 1602
)

pushd "%SOURCE%" >>"%LOGFILE%" 2>&1
if errorlevel 1 exit /b 104

rem INSTALLARGS must be verified for the specific package.
Setup.exe %INSTALLARGS% >>"%LOGFILE%" 2>&1
set "RC=%ERRORLEVEL%"
popd

>>"%LOGFILE%" echo Return code = %RC%

if exist "%VERIFYEXE%" (
    >>"%LOGFILE%" echo Installation verified
    if "%RC%"=="3010" exit /b 3010
    exit /b 0
)

>>"%LOGFILE%" echo Installation verification failed
if "%RC%"=="0" exit /b 105
exit /b %RC%
