Install-WindowsFeature DHCP -IncludeAllSubFeature -IncludeManagementTools
Add-DhcpServerInDC -DNSNAME Cesi.fr -IpAddress 192.168.77.10
Get-DhcpServerInDC
Add-DhcpServerv4Scope -Name "LAN_EntrepriseXYZ" -StartRange 192.168.77.50 -EndRange 192.168.77.200 -SubnetMask 255.255.255.0 -State Active
Get-DhcpServerv4Scope
Add-DhcpServerv4ExclusionRange -ScopeId 192.168.77.0 -StartRange 192.168.77.1 -EndRange 192.168.77.9
Set-DhcpServerv4OptionValue -ScopeId 192.168.77.0 -OptionId 3 -Value 192.168.77.2
Set-DhcpServerv4OptionValue -DnsServer 192.168.77.10
Add-DhcpServerv4Reservation -ScopeId 192.168.77.0 -IPAddress 192.168.77.58 -ComputerName DESKTOP-HKCGM1F -Description "reserved for administrator"