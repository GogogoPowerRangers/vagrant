#!/bin/sh
#
# This is a tenant configuration for a virtual server for Jesse's APM/SCM server
#
# create tenant[num].conf $tenant_ID tenant_UI_IP tenant_AGENT_IP 
#<VirtualHost 50.23.100.83:443>
#ServerName tenant1.customers-test.ap.apm.mycloudengage.com
#SSLEnable
#SSLProtocolDisable SSLv2
#ErrorLog "/opt/IBM/HTTPServer/logs/tenant1-ui-error.log"
#TransferLog "/opt/IBM/HTTPServer/logs/tenant1-ui-transfer.log"
#CustomLog "/opt/IBM/HTTPServer/logs/tenant1-ui-access.log" combined
#KeyFile "/opt/IBM/WebSphere/Plugins/etc/keyfile.kdb"
#SSLStashfile "/opt/IBM/WebSphere/Plugins/etc/keyfile.sth"
#SSLServerCert IBM_Tivoli_Monitoring_Certificate
#</VirtualHost>

echo "<VirtualHost $2:443>" > $1.conf
echo "ServerName $1.customers-test.ap.apm.mycloudengage.com" >> $1.conf
echo "SSLEnable" >> $1.conf
echo "SSLProtocolDisable SSLv2" >> $1.conf
echo ErrorLog "/opt/IBM/HTTPServer/logs/$1-ui-error.log" >> $1.conf
echo TransferLog "/opt/IBM/HTTPServer/logs/$1-ui-transfer.log" >> $1.conf
echo CustomLog "/opt/IBM/HTTPServer/logs/$1-ui-access.log" combined >> $1.conf
echo KeyFile "/opt/IBM/WebSphere/Plugins/etc/keyfile.kdb" >> $1.conf
echo SSLStashfile "/opt/IBM/WebSphere/Plugins/etc/keyfile.sth" >> $1.conf
echo SSLServerCert IBM_Tivoli_Monitoring_Certificate >> $1.conf
echo "</VirtualHost>"  >> $1.conf

#<VirtualHost 50.23.104.181:443>
#ServerName tenant1.agents-test.customers.ap.apm.mycloudengage.com
#SSLEnable
#SSLProtocolDisable SSLv2
#ErrorLog "/opt/IBM/HTTPServer/logs/tenant1-agent-error.log"
#TransferLog "/opt/IBM/HTTPServer/logs/tenant1-agent-transfer.log"
#CustomLog "/opt/IBM/HTTPServer/logs/tenant1-agent-access.log" combined
#KeyFile "/opt/IBM/WebSphere/Plugins/etc/keyfile.kdb"
#SSLStashfile "/opt/IBM/WebSphere/Plugins/etc/keyfile.sth"
#SSLServerCert IBM_Tivoli_Monitoring_Certificate
#</VirtualHost>

echo "<VirtualHost $3:443> "  >> $1.conf
echo ServerName $1.agents-test.customers.ap.apm.mycloudengage.com  >> $1.conf
echo SSLEnable  >> $1.conf
echo SSLProtocolDisable SSLv2  >> $1.conf
echo ErrorLog "/opt/IBM/HTTPServer/logs/$1-agent-error.log"  >> $1.conf
echo TransferLog "/opt/IBM/HTTPServer/logs/$1-agent-transfer.log"  >> $1.conf
echo CustomLog "/opt/IBM/HTTPServer/logs/$1-agent-access.log" combined  >> $1.conf
echo KeyFile "/opt/IBM/WebSphere/Plugins/etc/keyfile.kdb"  >> $1.conf
echo SSLStashfile "/opt/IBM/WebSphere/Plugins/etc/keyfile.sth"  >> $1.conf
echo SSLServerCert IBM_Tivoli_Monitoring_Certificate  >> $1.conf
echo "</VirtualHost>"  >> $1.conf


