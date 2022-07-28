   Connect-AzAccount 
 $Id = Get-Azsubscription
 Install-Module AzSK -Scope CurrentUser -SkipPublisherCheck 
Import-Module AzSK 
 foreach ($Ids in $Id)
 {
 $draft = Get-AzSKSubscriptionSecurityStatus -SubscriptionId $Ids.id
$children = Get-ChildItem -Filter *.csv $draft
azcopy copy "$draft/$children" "https://azsk1.blob.core.windows.net/azsk/?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2022-07-27T16:15:43Z&st=2022-07-27T08:15:43Z&spr=https,http&sig=8MXZcgy3yJBbaQGWTCME4ZpAOPFxBPB7OVUmjgFtPCI%3D" --recursive=true
 Remove-Item $draft
 }
 