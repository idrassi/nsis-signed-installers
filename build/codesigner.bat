@echo off
SETLOCAL

REM Extend the PATH to include Windows SDK tools
SET PATH=%PATH%;%WSDK81%\bin\x86;C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x86

REM Ensure a file was passed in as an argument
IF "%~1"=="" (
    echo Usage: %~nx0 [file-to-sign]
    EXIT /B 1
)

REM Set the certificate path relative to the batch file location
SET "CERT_PATH=%~dp0GlobalSign_SHA256_EV_CodeSigning_CA.cer"

REM Sign using SHA-256
signtool sign /v /sha1 86E1D426731E79117452F090188A828426B29B5F ^
  /ac "%CERT_PATH%" /fd sha256 /tr http://timestamp.digicert.com /td sha256 "%~1"

ENDLOCAL
