# Autodesk ODIS Deployment Framework

A reusable Windows deployment framework for analyzing and installing Autodesk products that use the Autodesk ODIS installation system.

> [!IMPORTANT]
> This repository contains scripts and documentation only. Do not upload Autodesk installer media, executables, product payloads, serial numbers, license information, internal server paths, or other proprietary/confidential content.

## Validated Project

The initial implementation was validated with:

- **Product:** Autodesk Navisworks Simulate 2025
- **Package type:** Standalone offline ODIS installer
- **ODIS install type:** `StandAloneInstall`
- **Bundle UPI2:** `{F74BDA04-F362-3D2C-BE40-309FBB5222B5}`
- **Application UPI2:** `{244B1E3B-1C51-31AC-B62E-F88B44E44C78}`
- **Validated command:** `Setup.exe -q`
- **Validated return code:** `0`
- **Verified executable:** `C:\Program Files\Autodesk\Navisworks Simulate 2025\roamer.exe`

The command was validated for this specific Navisworks Simulate 2025 media. Do not assume the same switch applies to every Autodesk installer. Inspect and test each package first.

## Features

- Portable source paths using `%~dp0`
- Administrator validation
- Required-file checks
- Running-application detection
- Central wrapper logging
- Installer return-code capture
- Post-install executable verification
- Generic template for other ODIS products
- SOP and product examples

## Repository Structure

```text
Autodesk-ODIS-Deployment-Framework
|
|-- README.md
|-- .gitignore
|-- LICENSE
|
|-- Scripts
|   |-- Navisworks2025_Install.cmd
|   |-- Navisworks_Message.vbs
|   `-- Generic_Autodesk_Install.cmd
|
|-- SOP
|   `-- Autodesk_Navisworks_2025_SOP.md
|
`-- Examples
    |-- AutoCAD2025_Example.md
    |-- Navisworks2025_Example.md
    `-- Revit2025_Example.md
```

## Local Installation Package Structure

Keep Autodesk media outside the GitHub repository:

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
    |-- 3rdParty
    |-- Content
    |-- manifest
    |-- ODIS
    |-- SetupRes
    |-- x64
    `-- x86
```

Copy the two files from `Scripts` beside the local `Media` folder. The wrapper automatically resolves `%~dp0Media`, so the package can run from `C:\Temp`, another drive, or another local directory without changing the source path.

## Package Identification

From the media root:

```cmd
findstr /i "DisplayName Application UPI2" setup.xml
```

Inspect ODIS configuration:

```cmd
type ODIS\bootstrap.json | more
```

Check executable metadata:

```cmd
powershell -NoProfile -Command "(Get-Item '.\Setup.exe').VersionInfo | Format-List ProductName,FileDescription,FileVersion,ProductVersion"
```

Check the digital signature:

```powershell
Get-AuthenticodeSignature -LiteralPath '.\Setup.exe' |
    Select-Object Status, StatusMessage,
        @{Name='Signer';Expression={$_.SignerCertificate.Subject}}
```

Do not execute media with an unexpected signer or invalid signature until its source has been verified.

## Validated Installation

For the tested Navisworks Simulate 2025 standalone ODIS package:

```cmd
Setup.exe -q
```

Run `Scripts\Navisworks2025_Install.cmd` as administrator after placing it beside the local `Media` folder.

## Logging

Wrapper log:

```text
C:\ProgramData\Autodesk\Logs\Navisworks2025_Install.log
```

ODIS logs may be available under:

```text
%LOCALAPPDATA%\Autodesk\ODIS
```

Product-specific logs may also be available under `%TEMP%`.

## Adapting the Template

For another product, update and validate:

- Product display name
- Running process name
- Expected installed executable
- Wrapper log filename
- Supported installer command

Examples are available in the `Examples` folder. Example executable paths are templates only and must be confirmed on a test device.

## Return Codes Used by the Navisworks Wrapper

```text
0     Installation and verification succeeded
100   Administrator privileges are required
101   Setup.exe is missing
102   setup.xml is missing
103   AdODIS-installer.exe is missing
104   Media directory could not be accessed
105   Installer returned success but verification failed
1602  Navisworks remained open and installation was cancelled
3010  Installation succeeded and restart is required
```

Other nonzero installer return codes are passed back when verification fails.

## Troubleshooting

View the wrapper log:

```cmd
type "%ProgramData%\Autodesk\Logs\Navisworks2025_Install.log"
```

List ODIS logs:

```cmd
dir /a /s /o-d "%LOCALAPPDATA%\Autodesk\ODIS\*.log"
```

List temporary logs:

```cmd
dir /a /s /o-d "%TEMP%\*.log"
```

Check Navisworks:

```cmd
tasklist /FI "IMAGENAME eq roamer.exe"
```

## GitHub Repository

Project repository:

[Autodesk ODIS Deployment Framework](https://github.com/Srinivasapatro/Autodesk-ODIS-Deployment-Framework)

## Security and Licensing

- Do not upload the `Media` directory.
- Do not upload Autodesk EXE, MSI, MSP, CAB, ISO, ZIP, 7Z, payload, or extracted content files.
- Do not commit serial numbers, license servers, user data, tokens, or internal network paths.
- Review logs and examples before publishing.
- Use Autodesk software only under the applicable organizational license and Autodesk terms.

## Disclaimer

This is an independent scripting and documentation project. Autodesk product names are used only to describe installation and interoperability examples. Autodesk installer media is not distributed with this repository. Autodesk and Autodesk product names are trademarks of Autodesk, Inc.

## Author

**Srinivasa PS**  
IT Analyst - Service Delivery

Focus areas:

- Windows administration
- Software packaging
- Endpoint management
- PowerShell and automation
- Cloud and DevOps engineering
