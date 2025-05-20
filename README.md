# NSIS Signed Installers

## Table of Contents
- [Why Signed NSIS Installers?](#why-signed-nsis-installers)
- [Download](#download)
- [Verification](#verification)
- [Build and Sign Yourself](#build-and-sign-yourself)
- [Security and Trust](#security-and-trust)
- [Version History](#version-history)
- [Contributing](#contributing)
- [Author](#author)

## Why Signed NSIS Installers?

The NSIS project currently does not publish signed binaries, creating risk for tampering. This repository offers code-signed, reproducible NSIS installers, built from source, with a transparent signing process.

These signed installers help ensure security in your software distribution pipeline.

## Download

### Current Release

- [NSIS 3.11 signed installer](https://github.com/idrassi/nsis-signed-installers/releases/download/nsis-3.11/nsis-3.11-setup-signed.exe) (1.82 MB)
- [SHA256SUMS](https://github.com/idrassi/nsis-signed-installers/releases/download/nsis-3.11/SHA256SUMS)

### Previous Releases

- [See all releases](releases/)

## Verification

To verify installer authenticity:

1. **Check code signature**
   - Right-click the installer → Properties → Digital Signatures
   - Verify certificate belongs to IDRIX and issued by GlobalSign (fingerprint: `86:E1:D4:26:73:1E:79:11:74:52:F0:90:18:8A:82:84:26:B2:9B:5F`)

2. **Verify checksums**
   ```powershell
   Get-FileHash -Algorithm SHA256 nsis-3.11-setup-signed.exe
   ```
   Compare with values in the [SHA256SUMS](releases/nsis-3.11/SHA256SUMS) file.

## Build and Sign Yourself

See [build/build-instructions.md](build/build-instructions.md) for step-by-step guidance on building and signing from source.

## Security and Trust

- All binaries are signed using IDRIX EV Code Signing Certificate (issued by GlobalSign)
  - Fingerprint: `86:E1:D4:26:73:1E:79:11:74:52:F0:90:18:8A:82:84:26:B2:9B:5F`
- Builds are reproducible following our documented process
- Source code matches official NSIS releases exactly (no modifications)

## Version History

| Version | Release Date | Changes |
|---------|--------------|---------|
| 3.11    | 2024-12-15   | Initial release of signed NSIS 3.11 installers |

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

- Report issues via GitHub Issues
- Submit improvements through Pull Requests
- Help improve build documentation

## Author

- **Mounir IDRASSI**
- Website: [https://amcrypto.jp](https://amcrypto.jp)
- GitHub: [@idrassi](https://github.com/idrassi)

*Last updated: May 20, 2025*
