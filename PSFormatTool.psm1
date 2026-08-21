function Initialize-Format {
<#
.SYNOPSIS
Formats a selected volume.

.PARAMETER DriveLetter
Specifies the drive letter of the volume to format. Provide one letter without
a trailing colon. The operating system volume cannot be formatted.

.PARAMETER FileSystem
Specifies the file system to apply. The supported values are exFAT and NTFS.

.PARAMETER NewName
Specifies the new label for the formatted volume. For exFAT volumes, the label
cannot contain more than 11 characters.
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Parameter(Mandatory = $true)]
        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem,

        [String]$NewName
    )
    $DiskInfo = Get-Volume -DriveLetter $DriveLetter -ErrorAction SilentlyContinue
    if (-not $DiskInfo) {
        throw "The specified volume could not be found."
    }
    if ($DriveLetter -eq $env:SystemDrive.TrimEnd(':')) {
        throw "The selected volume contains the operating system and cannot be modified."
    }
    if ($FileSystem -eq "exFAT") {
        if ($NewName.length -gt 11) {
            throw "You cannot enter more than 11 characters for the label in the exFat format."
        }
    }
    if ($PSCmdlet.ShouldProcess("Volume $($DiskInfo.FileSystemLabel) - $($DiskInfo.DriveLetter) - $($DiskInfo.DriveType)", "All data will be deleted for a new format.")) {
        try {
            Format-Volume -DriveLetter $DriveLetter -FileSystem $FileSystem -NewFileSystemLabel $NewName -ErrorAction Stop | Out-Null
            Write-Verbose "Format completed successfully."
        }   catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}
function New-Format {
<#
.SYNOPSIS
Validates and formats the selected volume.

.DESCRIPTION
Displays the available volumes and formats the selected volume as exFAT or
NTFS after verifying that it exists. Formatting permanently deletes all data
on the selected volume. The operating system volume is protected and cannot
be formatted.

.PARAMETER DriveLetter
Specifies the drive letter of the volume to format. Provide one letter without
a trailing colon. The operating system volume cannot be formatted.

.PARAMETER FileSystem
Specifies the file system to apply. The supported values are exFAT and NTFS.

.PARAMETER NewName
Specifies the new label for the formatted volume. For exFAT volumes, the label
cannot contain more than 11 characters.

.EXAMPLE
PS> New-Format -DriveLetter G -FileSystem exFAT -NewName "Data"

Formats drive G as exFAT and assigns it the label "Data". The command can
request confirmation according to the current PowerShell preference.

.NOTES
This function is the public entry point of the module and requires
administrator privileges. It supports -WhatIf and -Confirm.
#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem,

        [String]$NewName
    )
    try {
        Get-Volume -ErrorAction Stop| Format-Table
        Initialize-Format `
            @PSBoundParameters
    }   catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}
Export-ModuleMember -Function New-Format