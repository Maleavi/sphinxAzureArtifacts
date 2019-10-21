[CmdletBinding()]
param (
[String] $ip,
[int32] $prefix,
[String] $hostname,
[String] $dnsip
)

Rename-Computer -NewName $hostname
New-NetIPAddress -InterfaceAlias $netadapt -IPAddress $ip -PrefixLength $prefix
Set-DnsClientServerAddress -InterfaceAlias $netadapt -ServerAddresses $dnsip
Set-TimeZone -Id "W. Europe Standard Time"
Enable-PSRemoting -Force
Restart-Computer
