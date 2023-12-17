# SNMPV1

## Set Your `community string` Value in the `setup.sh` File:
```
comm_string=<VALUE>
```

## Start the Sandbox
```
./run.sh up;
.run.sh ssh;
```

## You Should be able to Run agent/snmpwalk Comnands and collect Basic snmp Metrics of Host:
```
snmpwalk -v 1 -c <COMMUNITY_STRING> -ObentU localhost:161 1.3
sudo datadog-agent snmp walk localhost:161 1.3 -C <COMMUNITY_STRING>
```
