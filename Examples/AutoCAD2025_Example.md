# AutoCAD 2025 Adaptation Example

> [!CAUTION]
> This is an adaptation template, not a statement that a particular AutoCAD media package has been validated. Confirm the installer mechanism, command, process, and executable path on a test device.

## Identify the Package

```cmd
findstr /i "DisplayName Application UPI2" setup.xml
```

```cmd
type ODIS\bootstrap.json | more
```

## Product-Specific Template Values

```bat
set "PRODUCTNAME=AutoCAD 2025"
set "PROCESSNAME=acad.exe"
set "VERIFYEXE=%ProgramFiles%\Autodesk\AutoCAD 2025\acad.exe"
set "LOGFILE=%LOGDIR%\AutoCAD2025_Install.log"
```

## Silent Command

Do not copy the Navisworks command automatically. Confirm the officially supported command for the exact AutoCAD package, then test it manually and capture `%ERRORLEVEL%`.

## Verification

Confirm the actual installed executable path on the test device before using it in the wrapper.
