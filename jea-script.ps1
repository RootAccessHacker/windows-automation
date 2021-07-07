#Date: 06/09/2021
#Edited: 07/7/2021

# Enables RCE
Enable-PSRemoting

$returnloc = Get-Location

Set-Location 'C:\Program Files\WindowsPowerShell\Modules\dctest\roleCapabilities'
$loc = Get-Location
$filename = "wmaint.psrc"
# Path to .psrc File
$file1 = "$loc/wmaint.psrc"

# Path to .pssc File
$file2 = "$loc/wmaint.pssc"

# PSRC File creation
$roleParameters = @{
    CompanyName = "DriesenG.hanze27"
    Path = "$file1"
    Description = "Role for Workstation Maintanance."
    VisibleExternalCommands = 'C:\Windows\System32\whoami.exe', 'C:\Windows\System32\ARP.EXE', 'C:\Windows\System32\PING.EXE', 'C:\Windows\System32\TRACERT.EXE', 'C:\Windows\System32\ipconfig.exe'
    VisibleCmdlets = "Get-Service", "Start-Service", "Restart-Service", "Get-Process", "Start-Process", "Stop-Process", "Restart-Process", "Get-EventLog", "Test-Connection", "Get-Date", "Copy-Item", "Get-Item", "Set-Item", "New-Item", "Remove-Item", "Rename-Item", "Move-Item", "Get-Date", "Set-Date", "Get-NetAdapter", "Set-NetAdapter", "Set-Location", "Set-TimeZone", "Get-ChildItem"
    VisibleProviders = 'FileSystem', 'Function', 'Variable'
}

New-PSRoleCapabilityFile @roleParameters

# PSSC File Creation
$configParameters = @{
    Path = $file2
    Description = "PSSession Configuration File"
    CompanyName = "DriesenG.hanze27"
    SessionType = "RestrictedRemoteServer"
    RunAsVirtualAccount = $true
    RoleDefinitions = @{ 'DriesenG.hanze27\ZjelkoRaznatovic' = @{ RoleCapabilities = 'wmaint' };}
    LanguageMode = "FullLanguage"
}

New-PSSessionConfigurationFile @configParameters
Register-PSSessionConfiguration -Name $filename -Path "$file2"
Restart-Service WinRM

echo "Configuration Complete"

Set-Location $returnloc
