[CmdletBinding()]
param(
    [string]$dnsip
)

$netadapt = (Get-NetAdapter).Name

Set-DnsClientServerAddress -InterfaceAlias $netadapt -ServerAddresses $dnsip
