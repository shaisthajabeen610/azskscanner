  Install-Module Az -AllowClobber -Force 
Import-Module Az   
Install-Module -Name AzSK -Scope CurrentUser -AllowClobber -Force -SkipPublisherCheck
Set-AzSKPolicySettings -OnlinePolicyStoreUrl "https://raw.githubusercontent.com/azsk/DevOpsKit/master/src/oss-config/`$Version/`$FileName"
Import-Module AzSK 
