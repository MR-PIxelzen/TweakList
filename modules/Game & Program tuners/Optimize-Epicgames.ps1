# Path to the .ini file
$iniFilePath = "$env:LocalAppData\EpicGamesLauncher\Saved\Config\Windows\GameUserSettings.ini"
Stop-Process -Name "Epic*" -Force
# Define the replacements
$replacements = @{
    "DisableGameTabs=\w+"                = "DisableGameTabs=False"
    "NotificationsEnabled_Adverts=\w+"   = "NotificationsEnabled_Adverts=False"
    "NotificationsEnabled_FreeGame=\w+"  = "NotificationsEnabled_FreeGame=False"
    "MinimiseToSystemTray=\w+"           = "MinimiseToSystemTray=False"
    "OfflineMode=\w+"                    = "OfflineMode=False"
    "Allow_InstallsWhileEditorsRunning=\w+"   = "Allow_InstallsWhileEditorsRunning=False"
    "LastActiveTab=\w+"                  = "LastActiveTab="
    "DownloadRateLimitEnabled=\w+"  = "DownloadRateLimitEnabled=False"
    "CloudSaveEnabled=\w+"                = "CloudSaveEnabled=False"

}
# Read the content of the .ini file
$iniContent = Get-Content -Path $iniFilePath -Raw

# Perform the replacements
foreach ($pattern in $replacements.Keys) {
    $replacement = $replacements[$pattern]
    $iniContent = $iniContent -replace $pattern, $replacement
}
# Write the updated content back to the .ini file
$iniContent | Out-File -Encoding Default -FilePath $iniFilePath

# Echo the changes
$updatedContent = Get-Content -Path $iniFilePath
foreach ($key in $replacements.Keys) {
    $replacement = $replacements[$key]
    $updatedLine = $updatedContent | Select-String -Pattern $replacement
    if ($updatedLine) {
        Write-Host $updatedLine
    }
}
#Write-Host "The specified keys have been updated to 'True' in '$iniFilePath'."
