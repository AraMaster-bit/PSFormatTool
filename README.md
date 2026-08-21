# PSFormatTool

Powershell module for automated volume format.

## Overview

PSFormatTool is a Powershell module for automating format preparation on volumes that do not host operating systems.

The module performs a complete volume format workflow:
- Validates the selected volume.
- Detects and prevents operations on volumes containing the operating system.
- Formats volumes using exFAT or NTFS.

## Features

- Operating system volume detection for safety.
- exFAT and NTFS filesystem support.
- Control over volume letters from A to Z.
- PowerShell `-WhatIf` and `-Confirm` support.
- Optional volume labels with `-NewName`.
- Verbose execution output.

## Requirements

- Windows 10, Windows 11, or Windows Server.
- PowerShell 5.1 or PowerShell 7.
- Administrator privileges.

## Installation

Clone the repository:

```powershell
git clone https://github.com/AraMaster-bit/PSFormatTool.git
Import-Module .\PSFormatTool\PSFormatTool.psd1
```

## Usage

Format a volume as exFAT and assign it a label:

```powershell
New-Format -DriveLetter G -FileSystem exFAT -NewName "Data"
```

The `DriveLetter` value must contain one letter without a trailing colon. For
exFAT volumes, `NewName` cannot contain more than 11 characters. Formatting
permanently deletes all data on the selected volume, and the operating system
volume cannot be formatted.

Use `-WhatIf` to preview the operation:

```powershell
New-Format -DriveLetter G -FileSystem NTFS -NewName "Backup" -WhatIf
```