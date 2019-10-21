﻿param([string]$netadapt= (Get-NetAdapter).Name, 
    [string]$dnsip="192.168.0.1")

Set-DnsClientServerAddress -InterfaceAlias $netadapt -ServerAddresses $dnsip
