# Enables RCE
Enable-PSRemoting

Set-Location 'C:\Program Files\WindowsPowerShell\Modules\dctest\roleCapabilities'
$loc = Get-Location
$filename = "workstation_maintenance.psrc"
# Path to .psrc File
$file1 = "$loc/workstation_maintenance.psrc"

# Path to .pssc File
$file2 = "$loc/workstation_maintenance.pssc"

# PSRC File creation
$roleParameters = @{
    Author=  "Dimitri K"
    CompanyName = "DriesenG"
    Path = "$file1"
    Description = "Role for Workstation Maintanance."
    VisibleExternalCommands = 'C:\Windows\System32\whoami.exe', 'C:\Windows\System32\ARP.EXE', 'C:\Windows\System32\PING.EXE', 'C:\Windows\System32\TRACERT.EXE', 'C:\Windows\System32\ipconfig.exe', 'C:\Windows\System32'
    VisibleCmdlets = "Get-Service", "Start-Service", "Restart-Service", "Get-Process", "Start-Process", "Stop-Process", "Restart-Process", "Get-EventLog", "Test-Connection", "Get-Date", "Copy-Item", "Get-Item", "Set-Item", "New-Item", "Remove-Item", "Rename-Item", "Move-Item", "Get-Date", "Set-Date", "Get-NetAdapter", "Set-NetAdapter", "Set-Location", "Set-TimeZone", "Get-ChildItem"

}
New-PSRoleCapabilityFile @roleParameters

# PSSC File Creation

$roles = @{ 'DriesenG.hanze27\Helpdeskmedewerkers' = @{ RoleCapabilities = 'workstation_maintenance' }}

$configParameters = @{
    Author = "Dimitri K"
    Path = $file2
    Description = "PSSession Configuration File"
    SessionType = "RestrictedRemoteServer"
    RequiredGroups = @{ Or = "Helpdeskmedewerkers" }
    RunAsVirtualAccount = $true
}

New-PSSessionConfigurationFile @configParameters -RoleDefinitions $roles
Register-PSSessionConfiguration -Name $filename -Path "$file2"
Restart-Service -Name WinRM
