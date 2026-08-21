# Autodesk Revit 2025 Adaptation Example

> [!CAUTION]
> This is an adaptation template. Confirm the exact Revit package mechanism, supported command, process, and installed executable path before deployment.

## Identify the Package

```cmd
findstr /i "DisplayName Application UPI2" setup.xml
```

```cmd
type ODIS\bootstrap.json | more
```

## Product-Specific Template Values

```bat
set "PRODUCTNAME=Autodesk Revit 2025"
set "PROCESSNAME=Revit.exe"
set "VERIFYEXE=%ProgramFiles%\Autodesk\Revit 2025\Revit.exe"
set "LOGFILE=%LOGDIR%\Revit2025_Install.log"
```

## Silent Command

Determine the officially supported silent-install command for the exact Revit media and validate it before adding it to the generic wrapper.

## Verification

Confirm the actual installed executable path and perform a functional launch test.
