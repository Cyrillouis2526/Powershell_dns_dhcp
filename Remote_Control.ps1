Add-WindowsFeature RDS-RD-Server -Restart
Import-Module RemoteDesktop
Get-Command -Module RemoteDesktop
New-RDSessionDeployment -ConnectionBroker WQIN-RM7C6M5KT90.Cesi.fr -SessionHost WIN-RM7C6M5KT90.Cesi.fr -WebAccessServer WIN-RM7C6M5KT90.Cesi.fr
Add-RDServer -Server WIN-RM7C6M5KT90.Cesi.fr -Role RDS-LICENSING -ConnectionBroker WIN-RM7C6M5KT90.Cesi.fr
New-RDSessionCollection -CollectionName "Collection_Bureau" -CollectionDescription "Collection RDS pour accéder aux apps Cesi.fr" -ConnectionBroker WIN-RM7C6M5KT90.Cesi.fr -SessionHost WIN-RM7C6M5KT90.Cesi.fr
New-RDRemoteApp -Alias WordPad -DisplayName WordPad -FilePath "C:\Program Files\Windows NT\Accessories\WordPad.exe" -ShowInWebAccess 1 -CollectionName "Collection_Bureau" -ConnectionBroker WIN-RM7C6M5KT90.Cesi.fr
Set-RDLicenseConfiguration -LicenseServer WIN-RM7C6M5KT90.Cesi.fr -Mode PerUser -ConnectionBroker WIN-RM7C6M5KT90.Cesi.fr

New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName "WIN-RM7C6M5KT90.Cesi.fr"

$cert = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Subject -like "*WIN-RM7C6M5KT90.Cesi.fr*" }

Set-RDCertificate -Role RDWebAccess -Thumbprint $cert[0].Thumbprint -ConnectionBroker "WIN-RM7C6M5KT90.Cesi.fr"
Set-RDCertificate -Role RDPublishing -Thumbprint $cert[0].Thumbprint -ConnectionBroker "WIN-RM7C6M5KT90.Cesi.fr"
Set-RDCertificate -Role RDGateway -Thumbprint $cert[0].Thumbprint -ConnectionBroker "WIN-RM7C6M5KT90.Cesi.fr"


Restart-Service termservice -Force
Restart-Service tssdis -Force
Restart-Service rdwebaccess -Force