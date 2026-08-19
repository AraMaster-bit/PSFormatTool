@{
    RootModule              ='PSFormatTool.psm1'
    ModuleVersion           ='0.1.1'
    GUID                    ='2e8300f5-7ff8-48e7-9161-ddf0ab83147a'
    Author                  ='Ara'
    PowerShellVersion       ='5.1'
    CompatiblePSEditions    =@('Desktop', 'Core')
    Description             ='Powershell module for automated volume format'
    FunctionsToExport       =@(
        'New-Format'
    )
    RequiredModules         =@()
}