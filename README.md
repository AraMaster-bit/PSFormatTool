# PSFormatTool

Powershell module for automated volume format.

## Overview

PSFormatTool is a Powershell module for automating format preparation on volumes that do not host operating systems.

The module performs a complete volume format workflow:
- Validates the selected volume.
- Detects and prevents operations on volumes containing the operating system.
- Formats partitions using exFAT or NTFS.

## Features

- Operating system volume detection for safety.
- exFAT and NTFS filesystem support.
- Control over volume letters from A to Z.
- Powershell `-WhatIf` and `-Confirm` support.
- Verbose execution output.

## Requirements

- Windows 10, Windows 11, or Windows Server.
- PowerShell 5.1 or PowerShell 7.
- Administrator privileges.

## Installation

Clone the repository:

```powershell
git clone https://github.com/AraMaster-bit/PSFormatTool.git