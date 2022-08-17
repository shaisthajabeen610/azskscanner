
    Install-Module Az -Force
Import-Module Az   

az upgrade
Connect-AzAccount -UseDeviceAuthentication
 $Id = Get-Azsubscription
 
# Install-Module AzSK -Scope CurrentUser -SkipPublisherCheck  -Force
# Import-Module AzSK 
Install-Module -Name AzSK -Scope CurrentUser -AllowClobber -Force 
set-executionpolicy RemoteSigned -Scope Process -Force;
Import-Module AzSK;
Connect-AzAccount 
Set-AzSKPrivacyNoticeResponse -AcceptPrivacyNotice "yes";
$Id = Get-Azsubscription;
foreach ($Ids in $Id)
{
$draft = Get-AzSKSubscriptionSecurityStatus -SubscriptionId $Ids.id
$children = Get-ChildItem -Filter *.csv $draft
C:\source\azcopy.exe copy "$draft/$children" "https://azsk1.blob.core.windows.net/azsk/?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2022-08-25T15:30:48Z&st=2022-08-17T07:30:48Z&spr=https,http&sig=%2BVQcN%2F0WSg%2F1Xy9xmba4OYTHJooTJeW9%2FpI0Ttjxuog%3D" --recursive=true
}
