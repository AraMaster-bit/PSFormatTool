function Initialize-Format{
<#
.SYNOPSIS
Formats a selected volume.

.PARAMETER DriveLetter
Specifies the drive letter of the volume to format.

.PARAMETER FileSystem
Specifies the file system to apply. The supported values are exFAT and NTFS.
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Parameter(Mandatory = $true)]
        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem
    )
    try{
        Format-Volume -DriveLetter $DriveLetter -FileSystem $FileSystem -ErrorAction Stop | Out-Null
        Write-Verbose "Format completed successfully."
    }   catch{
        $PSCmdlet.ThrowTerminatingError($_)
    }
}
function New-Format{
<#
.SYNOPSIS
Validates and formats the selected volume.

.DESCRIPTION
Formats the selected volume as exFAT or NTFS after verifying that the volume exists.
The system volume is protected by this function and cannot be formatted.

.PARAMETER DriveLetter
Specifies the drive letter of the volume to format.

.PARAMETER FileSystem
Specifies the file system to apply. The supported values are exFAT and NTFS.

.EXAMPLE
PS> New-Format -DriveLetter G -FileSystem exFAT

Formats drive G as exFAT after requesting confirmation.

.NOTES
This function is the public entry point of the script. The system volume is
protected here and cannot be formatted.

Validates the selected volume and performs the formatting workflow.
The function supports -WhatIf and -Confirm.
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Parameter(Mandatory = $true)]
        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem
    )
    $DiskInfo = Get-Volume -DriveLetter $DriveLetter -ErrorAction SilentlyContinue
    if(-not $DiskInfo){
        throw "The specified volume could not be found."
    }
    if($DriveLetter -eq $env:SystemDrive.TrimEnd(':')){
        throw "The selected volume contains the operating system and cannot be modified."
    }
    if($PSCmdlet.ShouldProcess("Volume $($DiskInfo.FileSystemLabel) - $($DiskInfo.DriveLetter) - $($DiskInfo.DriveType)", "All data will be deleted for a new format.")){
        try{
            Initialize-Format `
                @PSBoundParameters
        }   catch{
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}
Export-ModuleMember -Function New-Format