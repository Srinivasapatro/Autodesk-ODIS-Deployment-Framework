# Autodesk Navisworks Simulate 2025 Example

## Status

This is the validated example in this repository.

## Identification

```cmd
findstr /i "DisplayName Application UPI2" setup.xml
```

Identified product:

```text
Autodesk Navisworks Simulate 2025
```

ODIS package type found in `ODIS\bootstrap.json`:

```json
"install_type": "StandAloneInstall"
```

## Validated Command

```cmd
Setup.exe -q
```

## Running Process

```text
roamer.exe
```

## Verification

```text
C:\Program Files\Autodesk\Navisworks Simulate 2025\roamer.exe
```

## Tested Result

```text
Return code = 0
Installation verified
```
