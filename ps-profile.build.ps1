task Install {
    $Profile = "$PSScriptRoot\Microsoft.PowerShell_profile.ps1"
    $Target = @(
        "${env:UserProfile}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
        "${env:UserProfile}\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1"
        "${env:UserProfile}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
        "${env:UserProfile}\Documents\PowerShell\Microsoft.VSCode_profile.ps1"
    )
    $Target `
    | ForEach-Object { New-Item -Type HardLink -Path $Profile -Target $_ -Force }
}