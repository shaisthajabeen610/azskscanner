   
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    $webClient = New-Object -TypeName System.Net.WebClient
$webClient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber
    $envarname = "PSModulePath"
$envar = (get-item env:$envarname).Value
[Environment]::SetEnvironmentVariable($envarname, $envar + ";C:\Expedited", "Machine")
$AzSKModuleRepoPath = "https://azsdkossep.azureedge.net/3.7.0/AzSK.zip"

#Copy module zip to temp location
$CopyFolderPath = $env:temp + "\AzSKTemp\"
if(-not (Test-Path -Path $CopyFolderPath))
{
  mkdir -Path $CopyFolderPath -Force | Out-Null
}
$ModuleFilePath = $CopyFolderPath + "AzSK.zip"           
Invoke-WebRequest -Uri $AzSKModuleRepoPath -OutFile $ModuleFilePath

#Extract zip file to module location
Expand-Archive -Path $ModuleFilePath -DestinationPath "$Env:USERPROFILE\documents\WindowsPowerShell\modules" -Force

#Clean up temp location
Remove-Item –path $CopyFolderPath –recurse
    Connect-AzAccount -UseDeviceAuthentication
 $Id = Get-Azsubscription
 Install-Module AzSK -Scope CurrentUser -SkipPublisherCheck -AllowClobber -Force
#Import-Module AzSK 
 foreach ($Ids in $Id)
 {
 $draft = Get-AzSKSubscriptionSecurityStatus -SubscriptionId $Ids.id
$children = Get-ChildItem -Filter *.csv $draft
azcopy copy "$draft/$children" "https://azsk1.blob.core.windows.net/azsk/?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2022-07-28T21:07:10Z&st=2022-07-28T13:07:10Z&spr=https&sig=Aw41bTLEimlGyw3rgyi7JXnijAijpnZk4sXBCZmCnGQ%3D" --recursive=true
 
 }

# Remove-Item $draft
 
