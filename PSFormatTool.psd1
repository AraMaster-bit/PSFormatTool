@{
    RootModule              ='PSPartitionTool.psm1'
    ModuleVersion           ='0.1.0'
    GUID                    ='2e8300f5-7ff8-48e7-9161-ddf0ab83147a'
    Author                  ='AraMaster-bit'
    PowerShellVersion       ='5.1'
    CompatiblePSEditions    =@('Desktop', 'Core')
    Description             ='Powershell module for automated volume format'
    FunctionsToExport       =@(
        'Initialize-Format'
    )
    RequiredModules         =@()
}