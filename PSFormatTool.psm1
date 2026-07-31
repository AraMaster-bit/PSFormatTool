<#[
.SYNOPSIS
Format specified volumes.

.DESCRIPTION
Erase all data on the volume and reformat the volume.

.PARAMETER DriveLetter
Specify the volume letter.

.PARAMETER FileSystem
Specify the format type.

.EXAMPLE
PS> New-Format -DriveLetter G -FileSystem exFAT

Delete the data on Volume G and apply the exFAT format.

.NOTES
This function runs as a second step after starting the workflow. 
And removes the data from the volume by applying a new format.
]#>
    function New-Format{
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Parameter(Mandatory = $true)]
        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem
        )
    if($PSCmdlet.ShouldProcess("Disk $Driveletter", "Applying the format.")){
        try{
            Format-Volume -DriveLetter $DriveLetter -FileSystem $FileSystem -Confirm:$false -ErrorAction Stop | Out-Null
            Write-Verbose "Format completed successfully."
        }   catch{
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}
<#[
.SYNOPSIS
Initialize the format.

.DESCRIPTION
Formats the specific volume, denies execution if it verifies that an active OS exists.

.PARAMETER DriveLetter
Specify the volume letter.

.PARAMETER FileSystem
Specify the format type.

.EXAMPLE
PS> Initialize-Format -DriveLetter G -FileSystem exFAT

Delete the data on Volume G and apply the exFAT format.

.NOTES
This is the main function of the script. Validates the selected volume and orchestrates the 
entire volume formatting workflow.
]#>
function Initialize-Format{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "High")]
    param(
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Parameter(Mandatory = $true)]
        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem
    )
    if($PSCmdlet.ShouldProcess("Volume $DriveLetter", "All data will be deleted for a new format.")){
        try{
            Get-Volume -DriveLetter $DriveLetter -ErrorAction Stop
            Write-Verbose "Successful volume check."
        }   catch{
            Write-Error "The specified volume could not be found."
            return
        }
        if($DriveLetter -eq $env:SystemDrive.TrimEnd(':')){
            Write-Error "The selected volume contains the operating system and cannot be modified."
            return
        }
        New-Format `
        -DriveLetter $DriveLetter `
        -FileSystem $FileSystem
    }
}
Export-ModuleMember -Function Initialize-Format