   Connect-AzAccount 
 $Id = Get-Azsubscription
 Install-Module AzSK -Scope CurrentUser -SkipPublisherCheck 
Import-Module AzSK 
 foreach ($Ids in $Id)
 {
 $draft = Get-AzSKSubscriptionSecurityStatus -SubscriptionId $Ids.id
$children = Get-ChildItem -Filter *.csv $draft
azcopy copy "$draft/$children" "https://azsk1.blob.core.windows.net/azsk/?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2022-07-28T21:07:10Z&st=2022-07-28T13:07:10Z&spr=https&sig=Aw41bTLEimlGyw3rgyi7JXnijAijpnZk4sXBCZmCnGQ%3D" --recursive=true
 
 }

# Remove-Item $draft
 