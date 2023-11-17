# SNMP V3

## SNMP V3 Configuration:
```
auth-protocol string=SHA
auth-key string=$auth_key_string
priv-proto string=AES
priv-key string=$priv_key_string 
security-level string=authPriv
user=$snmpv3_user
```

## Configure in `setup.sh` File the Values:
```
auth_key_string=<VAlUE>
priv_key_string=<VAlUE>
snmpv3_user=<VAlUE>
```

## Spin Up Sandbx:
```
./run.sh up;
./run.sh ssh
```

### To Run `snmpwalk` Commands:

#### 1. Use the `<VALUE>` Set in `setup.sh` File:
```
$auth_key_string=<AUTH_VALUE>
$priv_key_string=<PRIV_VALUE>
$snmpv3_user=<USER_VALUE>
```

#### 2. Or Set Environment Variables:
```
export auth_key_string=<VALUE>;
export priv_key_string=<VALUE>;
export snmpv3_user=<VALUE>
```
## `snmpwalk` Commands:
```
netstat -nlpu|grep snmp -v 'will display snmp walk output'
snmpwalk -v 3 -a SHA -A $auth_key_string -x AES -X $priv_key_string -l authPriv -u $snmpv3_user localhost:161
sudo datadog-agent snmp walk localhost:161 1.3 -v 3 -a SHA -A $auth_key_string -x AES -X $priv_key_string -l authPriv -u $snmpv3_user  
```

##  Verbose `snmp` Metrics Should Be Collecting into Datadog
