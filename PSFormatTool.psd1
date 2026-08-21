@{
    RootModule              ='PSFormatTool.psm1'
    ModuleVersion           ='0.1.2'
    GUID                    ='2e8300f5-7ff8-48e7-9161-ddf0ab83147a'
    Author                  ='AraMaster-bit'
    PowerShellVersion       ='5.1'
    CompatiblePSEditions    =@('Desktop', 'Core')
    Description             ='PowerShell module for automated volume formatting'
    FunctionsToExport       =@(
        'New-Format'
    )
    RequiredModules         =@()
}