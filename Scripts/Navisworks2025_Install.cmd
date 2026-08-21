@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem ============================================================
rem Autodesk Navisworks Simulate 2025 silent installation
rem Validated media command: Setup.exe -q
rem ============================================================

set "SOURCE=%~dp0Media"
set "LOGDIR=%ProgramData%\Autodesk\Logs"
set "LOGFILE=%LOGDIR%\Navisworks2025_Install.log"
set "VERIFYEXE=%ProgramFiles%\Autodesk\Navisworks Simulate 2025\roamer.exe"
set "MESSAGE=%~dp0Navisworks_Message.vbs"

if not exist "%LOGDIR%" md "%LOGDIR%" 2>nul

>"%LOGFILE%" echo =====================================================
>>"%LOGFILE%" echo Autodesk Navisworks Simulate 2025
>>"%LOGFILE%" echo Started: %DATE% %TIME%
>>"%LOGFILE%" echo Computer: %COMPUTERNAME%
>>"%LOGFILE%" echo User: %USERDOMAIN%\%USERNAME%
>>"%LOGFILE%" echo Source: %SOURCE%
>>"%LOGFILE%" echo =====================================================

fltmc >nul 2>&1
if errorlevel 1 (
    echo ERROR: Run this script as Administrator.
    >>"%LOGFILE%" echo ERROR: Administrator privileges are required.
    pause
    exit /b 100
)

if not exist "%SOURCE%\Setup.exe" (
    echo ERROR: Setup.exe was not found.
    >>"%LOGFILE%" echo ERROR: Missing "%SOURCE%\Setup.exe"
    pause
    exit /b 101
)

if not exist "%SOURCE%\setup.xml" (
    echo ERROR: setup.xml was not found.
    >>"%LOGFILE%" echo ERROR: Missing "%SOURCE%\setup.xml"
    pause
    exit /b 102
)

if not exist "%SOURCE%\ODIS\AdODIS-installer.exe" (
    echo ERROR: AdODIS-installer.exe was not found.
    >>"%LOGFILE%" echo ERROR: Missing "%SOURCE%\ODIS\AdODIS-installer.exe"
    pause
    exit /b 103
)

tasklist /FI "IMAGENAME eq roamer.exe" /NH 2>nul | find /I "roamer.exe" >nul
if not errorlevel 1 (
    >>"%LOGFILE%" echo BLOCKED: roamer.exe is currently running.

    if exist "%MESSAGE%" (
        cscript.exe //NoLogo "%MESSAGE%" >>"%LOGFILE%" 2>&1
    )

    tasklist /FI "IMAGENAME eq roamer.exe" /NH 2>nul | find /I "roamer.exe" >nul
    if not errorlevel 1 (
        echo ERROR: Navisworks is still running.
        >>"%LOGFILE%" echo ERROR: Navisworks remained open. Return code 1602.
        pause
        exit /b 1602
    )
)

pushd "%SOURCE%" >>"%LOGFILE%" 2>&1
if errorlevel 1 (
    echo ERROR: The Media directory could not be accessed.
    >>"%LOGFILE%" echo ERROR: pushd failed for "%SOURCE%"
    pause
    exit /b 104
)

>>"%LOGFILE%" echo Starting Setup.exe
Setup.exe -q >>"%LOGFILE%" 2>&1
set "RC=%ERRORLEVEL%"
>>"%LOGFILE%" echo Return code = %RC%

popd

if exist "%VERIFYEXE%" (
    >>"%LOGFILE%" echo Installation verified
    echo Installation completed successfully.

    if "%RC%"=="3010" (
        echo A restart is required.
        >>"%LOGFILE%" echo Restart required
        pause
        exit /b 3010
    )

    pause
    exit /b 0
)

>>"%LOGFILE%" echo Installation verification failed
echo Installation could not be verified.
echo Review the log: "%LOGFILE%"
pause

if "%RC%"=="0" exit /b 105
exit /b %RC%
