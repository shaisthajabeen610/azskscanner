 
    Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber -Confirm
    $envarname = "PSModulePath"






$InstallPath = 'C:\AzCopy'

# Cleanup Destination
if (Test-Path $InstallPath) {
    Get-ChildItem $InstallPath | Remove-Item -Confirm:$false -Force
}

# Zip Destination
$zip = "$InstallPath\AzCopy.Zip"

# Create the installation folder (eg. C:\AzCopy)
$null = New-Item -Type Directory -Path $InstallPath -Force

# Download AzCopy zip for Windows
Start-BitsTransfer -Source "https://aka.ms/downloadazcopy-v10-windows" -Destination $zip

# Expand the Zip file
Expand-Archive $zip $InstallPath -Force

# Move to $InstallPath
Get-ChildItem "$($InstallPath)\*\*" | Move-Item -Destination "$($InstallPath)\" -Force

#Cleanup - delete ZIP and old folder
Remove-Item $zip -Force -Confirm:$false
Get-ChildItem "$($InstallPath)\*" -Directory | ForEach-Object { Remove-Item $_.FullName -Recurse -Force -Confirm:$false }

# Add InstallPath to the System Path if it does not exist
if ($env:PATH -notcontains $InstallPath) {
    $path = ($env:PATH -split ";")
    if (!($path -contains $InstallPath)) {
        $path += $InstallPath
        $env:PATH = ($path -join ";")
        $env:PATH = $env:PATH -replace ';;', ';'
    }
    [Environment]::SetEnvironmentVariable("Path", ($env:path), [System.EnvironmentVariableTarget]::Machine)
}

Connect-AzAccount -UseDeviceAuthentication

 $Id = Get-Azsubscription
 Install-Module AzSK -Scope CurrentUser -SkipPublisherCheck -AllowClobber -Force -Confirm

 foreach ($Ids in $Id)
 {

 $draft = Get-AzSKSubscriptionSecurityStatus -SubscriptionId $Ids.id  -ErrorAction SilentlyContinue
$children = Get-ChildItem -Filter *.csv $draft
$storage_account =  https://azsk1.blob.core.windows.net/azsk/?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2022-07-29T12:43:33Z&st=2022-07-29T04:43:33Z&spr=https&sig=85hkhqeLQ1ktA7GPSGkvZHuGOusg1bwuI%2FEfliJTGBU%3D
azcopy copy $draft/$children $storage_account --recursive=true  -ErrorAction SilentlyContinue
 
 }

# Remove-Item $draft
 
