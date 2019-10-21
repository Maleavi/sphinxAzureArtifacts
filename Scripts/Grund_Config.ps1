﻿param($netadapt= (Get-NetAdapter).Name,
$ip="192.168.0.1",
$prefix=24,
$dnsip="192.168.0.1",
$pfad="C:\Users\Vahid\Desktop\starter.ps1")

Rename-Computer -NewName "DC01"
New-NetIPAddress -InterfaceAlias $netadapt -IPAddress $ip -PrefixLength $prefix
Set-DnsClientServerAddress -InterfaceAlias $netadapt -ServerAddresses $dnsip
Set-TimeZone -Id "W. Europe Standard Time"
Enable-PSRemoting -Force
Restart-Computer
