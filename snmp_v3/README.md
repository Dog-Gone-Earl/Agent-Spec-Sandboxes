# SNMP V3

## SNMP V3 Configuration:
<code>
auth-protocol string=SHA
auth-key string=$auth_key_string #configured in setup.sh
priv-proto string=AES
priv-key string=$priv_key_string #configured in setup.sh
security-level string=authPriv
user: $snmpv3_user #configured in setup.sh
</code>

## Verification Commands:

### For `snmpwalk` Commands Replace Placeholders with Values:
`
auth-key string=$auth_key_string #configured in setup.sh
priv-key string=$priv_key_string #configured in setup.sh
user: $snmpv3_user #configured in setup.sh
`
<code>netstat -nlpu|grep snmp -v 'will display snmp walk output'
snmpwalk -v 3 -a SHA -A $auth_key_string -x AES -X $priv_key_string -l authPriv -u $snmpv3_user localhost:161
sudo datadog-agent snmp walk localhost:161 1.3 -v 3 -a SHA -A $auth_key_string -x AES -X $priv_key_string -l authPriv -u $snmpv3_user  
</code>