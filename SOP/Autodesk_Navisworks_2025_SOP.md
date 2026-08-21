# SOP: Autodesk Navisworks Simulate 2025 Silent Installation

## 1. Purpose

This SOP describes the validated silent installation process for Autodesk Navisworks Simulate 2025 using standalone Autodesk ODIS offline media.

## 2. Validated Package

- Product: Autodesk Navisworks Simulate 2025
- Framework: Autodesk ODIS
- Install type: `StandAloneInstall`
- Command: `Setup.exe -q`
- Tested return code: `0`
- Verification executable: `C:\Program Files\Autodesk\Navisworks Simulate 2025\roamer.exe`

## 3. Local Package Structure

```text
Navisworks2025
|
|-- Navisworks2025_Install.cmd
|-- Navisworks_Message.vbs
|
`-- Media
    |-- Setup.exe
    |-- Setup.exe.config
    |-- setup.xml
    |-- ODIS
    |-- Content
    |-- manifest
    |-- SetupRes
    |-- x64
    `-- x86
```

## 4. Prerequisites

- Complete, authorized Autodesk Navisworks Simulate 2025 installation media
- Local administrator privileges
- Sufficient local disk space
- Navisworks closed before installation
- Approved Autodesk licensing/entitlement process

## 5. Package Verification

From the `Media` directory:

```cmd
findstr /i "DisplayName Application UPI2" setup.xml
```

Confirm that `setup.xml` identifies Autodesk Navisworks Simulate 2025.

Inspect ODIS configuration:

```cmd
type ODIS\bootstrap.json | more
```

Confirm that the package type matches the expected standalone ODIS media.

## 6. Installation Procedure

1. Copy the complete local installation package to the target computer.
2. Keep `Navisworks2025_Install.cmd` and `Navisworks_Message.vbs` beside the `Media` folder.
3. Close Navisworks and other Autodesk applications.
4. Right-click `Navisworks2025_Install.cmd`.
5. Select **Run as administrator**.
6. Allow the script and Autodesk installer to complete.
7. Review the wrapper log.
8. Verify `roamer.exe` exists.
9. Launch the product and complete the approved functional and licensing checks.

## 7. Log Location

```text
C:\ProgramData\Autodesk\Logs\Navisworks2025_Install.log
```

Expected successful entries:

```text
Starting Setup.exe
Return code = 0
Installation verified
```

## 8. Verification

```cmd
if exist "C:\Program Files\Autodesk\Navisworks Simulate 2025\roamer.exe" (
    echo Installed
) else (
    echo Not detected
)
```

## 9. Troubleshooting

Wrapper log:

```cmd
type "%ProgramData%\Autodesk\Logs\Navisworks2025_Install.log"
```

ODIS logs:

```cmd
dir /a /s /o-d "%LOCALAPPDATA%\Autodesk\ODIS\*.log"
```

Temporary logs:

```cmd
dir /a /s /o-d "%TEMP%\*.log"
```

Running process check:

```cmd
tasklist /FI "IMAGENAME eq roamer.exe"
```

## 10. Wrapper Return Codes

```text
0     Installation and verification succeeded
100   Administrator privileges are required
101   Setup.exe is missing
102   setup.xml is missing
103   AdODIS-installer.exe is missing
104   Media directory could not be accessed
105   Installer returned success but executable verification failed
1602  Navisworks remained open and installation was cancelled
3010  Installation succeeded and restart is required
```

## 11. Security

Do not upload Autodesk media, licensing data, credentials, organization-specific network paths, or user information to GitHub.
