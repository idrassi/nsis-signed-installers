# Building and Signing NSIS: Step-by-Step Guide

This guide describes how to **build, sign, and verify** NSIS installers in a transparent, reproducible, and secure way.

> **Why?**  
> The official NSIS project does not publish signed binaries. To ensure authenticity and mitigate the risk of supply chain attacks, we provide signed installers and full documentation for our build process.

---

## Prerequisites

- **Windows 10/11** system
- [Visual Studio 2019 or newer](https://visualstudio.microsoft.com/downloads/) with C++ build tools
- [Python 3.x](https://www.python.org/downloads/)
- [SCons](https://scons.org/) build tool (`pip install scons`)
- [HTML Help Workshop](https://aka.ms/htmlhelp) (for building NSIS help files)
- [Windows SDK](https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk/) (for signtool)
- EV Code Signing Certificate (imported to your system or available via HSM/smartcard)
- [zlib-win-build](https://github.com/kiyolee/zlib-win-build) project (for zlib dependency)
- This repository's `codesigner.bat` script and CA certificate file

---

## Environment Preparation

1. **Build zlib from source**

   Clone and build using [zlib-win-build](https://github.com/kiyolee/zlib-win-build).
   We use [zlib-win-build](https://github.com/kiyolee/zlib-win-build) to build zlib with Visual Studio.  
   **Before building, you must modify the Visual Studio solution to ensure compatibility with NSIS’s expectations:**

1. Open `build-VS2019-MT/zlib.sln` in Visual Studio.
2. In the Solution Explorer, right-click on the **libz** project and choose **Properties**.
3. Under **Configuration Properties → General**, locate **Target Name**.
4. **Change the target name from `libz` to `zlib`.**
    - This ensures the generated import library will be named `zlib.lib` (not `libz.lib`), which matches what NSIS expects when linking to `zlib.dll`.
    - **Why:** If this step is skipped, the NSIS build system will fail to find the import library, or worse, link incorrectly.

5. Build the Win32 Target
    - In Visual Studio, select the **Release | Win32** configuration.
    - Build the solution (Build → Build Solution).

6. Copy the resulting files to your build directory structure:
    - `zlib.dll` → `C:\dev\Progs\zlib\zlib.dll`
    - `zlib.lib` → `C:\dev\Progs\zlib\lib\zlib.lib`
    - Also create a copy: `C:\dev\Progs\zlib\lib\zdll.lib` (NSIS build script expect this library name).
    - `zlib.h` and `zconf.h` → `C:\dev\Progs\zlib\include\`

2. **Set environment variable**

   ```shell
   set ZLIB_W32=C:\dev\Progs\zlib
   ````

3. **Update PATH**

   Add zlib and HTML Help Workshop to PATH:

   ```shell
   set PATH=%PATH%;%ZLIB_W32%;C:\Program Files (x86)\HTML Help Workshop;
   ```

4. **Install Python and SCons**

   ```shell
   python -m pip install --upgrade pip
   pip install scons
   ```

---

## Building NSIS without signature

1. **Obtain NSIS source code**

   Download from the [official NSIS website](https://nsis.sourceforge.io/Download).

2. **Build NSIS**

   Open a command prompt in the NSIS source directory and run:

   ```shell
   scons SKIPUTILS="NSIS Menu" UNICODE=YES VERSION="3.11"
   scons VERSION="3.11" dist-installer
   ```

   > Adjust `"3.11"` to the NSIS version being built.

   You can also install the binaries to a specific directory:

   ```shell
   scons PREFIX="C:\dev\Progs\NSIS" VERSION="3.11" install
   ```
    > *Note: Replace `C:\dev\Progs\NSIS` with your desired installation path.*

---

## Signing All Binaries and Installer

1. **Prepare the signing script**

   Ensure `codesigner.bat` and the certificate file (`GlobalSign_SHA256_EV_CodeSigning_CA.cer`) are present in your working directory.

2. **Configure signtool**

   * Confirm `signtool.exe` is in your `PATH` (comes with Windows SDK).
   * Update the SHA1 certificate thumbprint in `codesigner.bat`.

3. **Sign during build**
   SCons can be told to use the codesigner for all produced binaries and the installer:

   ```shell
   scons SKIPUTILS="NSIS Menu" UNICODE=YES VERSION="3.11" CODESIGNER="C:\path\to\codesigner.bat" dist-installer
   ```

   > *Note: There is a build script bug preventing automatic signing of the final installer.*

4. **Manually sign the final installer**
   After the installer (`nsis-3.11-setup-signed.exe`) is built, sign it:

   ```shell
   codesigner.bat nsis-3.11-setup-signed.exe
   ```

---

## Verifying Signatures

To check that a binary is properly signed:

1. **Using Windows Explorer:**

   * Right-click the file → Properties → Digital Signatures.

2. **Using signtool:**

   ```shell
   signtool verify /pa nsis-3.11-setup-signed.exe
   ```

3. **Using PowerShell:**

   ```powershell
   Get-AuthenticodeSignature .\nsis-3.11-setup-signed.exe
   ```

---

## Updating for New Releases

* Update `VERSION` parameters for each new NSIS release.
* Adjust zlib source/build as needed for new dependencies.
* Review and, if needed, update code signing certificate details.

---

> *This document is a living record. Please submit improvements or clarifications as pull requests.*

