Install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature
Add-DnsServerPrimaryZone -Name entreprisexyz.local -ZoneFile entreprisexyz.local
Add-DnsServerPrimaryZone -NetworkId 192.168.77.0/24 -ZoneFile 77.168.192.in-addr.arpa.dns
Add-DnsServerResourceRecord -ZoneName entreprisexyz.local -Name srv-dc1 -A -IPv4Address 192.168.77.3
Add-DnsServerConditionalForwarderZone -Name Google -MasterServer 8.8.8.8,8.8.4.4 -ReplicationScope Forest
ADD-DnsServerForwarder -IPAddress 8.8.8.8,8.8.4.4