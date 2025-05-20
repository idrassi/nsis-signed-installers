# NSIS Signed Installers

## Why Signed NSIS Installers?

The NSIS project currently does not publish signed binaries, creating risk for tampering. This repository offers code-signed, reproducible NSIS installers, built from source, with a transparent signing process.

## Download

- [Latest signed installer (3.11)](releases/nsis-3.11/nsis-3.11-setup-signed.exe)
- [SHA256SUMS](releases/nsis-3.11/SHA256SUMS)

## Build and Sign Yourself

See [build/build-instructions.md](build/build-instructions.md) for step-by-step guidance.

## Security and Trust

- The distributed install and all its binaries are signed using IDRIX EV Code Signing Certificate (issued by GlobalSign).
  - Fingerprint: `86:E1:D4:26:73:1E:79:11:74:52:F0:90:18:8A:82:84:26:B2:9B:5F`
- Signing certificate details: [see here](releases/nsis-3.11/SIGNATURES.md)

