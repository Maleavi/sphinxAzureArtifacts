
param(
    [string]$dhcpip="192.168.0.1",
	[string]$dhcpfqdn="dhcp1.contoso.com",
	[string]$scopename="Sphinx Scope",
	[string]$dnsip="192.168.0.1",
	[string]$routerip="192.168.0.254",
	[string]$startrange="192.168.0.10",
	[string]$endrange="192.168.0.200",
	[string]$subnetmask="255.255.255.0"
	
	
)

#Installieren der Server Rolle
Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools

#DHCP als Secruity Gruppe anlegen 
netsh dhcp add securitygroups

Restart-Service dhcpserver

#Für die Autorisierung des DHCP Servers im AD
Add-DhcpServerInDC -DnsName $dhcpfqdn.Replace('"','') -IPAddress $dhcpip

#Um den Server Manager mitzuteilen das konfiguriert wurde 
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2

#Für dynamische DNS Updates
Set-DhcpServerv4DnsSetting -ComputerName $dhcpfqdn -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True

#Konfiguration des DHCP Servers
Add-DhcpServerV4Scope -Name $scopename -StartRange $startrange.Replace('"','') -EndRange $endrange.Replace('"','') -SubnetMask $subnetmask.Replace('"','') -State Active
$temp = $dhcpfqdn.split(".")

Set-DhcpServerV4OptionValue -DnsServer $dnsip.Replace('"','') -Router $routerip.Replace('"','') -DnsDomain contoso.com -ComputerName $dhcpfqdn.Replace('"','')

#Dem Server-Manager mitteilen, dass die DHCP Konfig gemacht wurde
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2

