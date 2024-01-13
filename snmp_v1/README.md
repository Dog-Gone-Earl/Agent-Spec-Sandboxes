# sandbox/vagrant/agent7/snmp_v1

## What this VM does

- Test snmp (v1) functionaity with Agent

## VM type: Linux Ubuntu

## Special Instructions

### 1. Set a `community string` Value in the `setup.sh` File:
```
comm_string=<VALUE>
```

### 2. Start the Sandbox
```
./run.sh up;
.run.sh ssh;
```

### 3. You Should be able to Run `agent snmpwalk` and host `snmpwalk` Comnands to poll OID's:

#### Example:
```
snmpwalk -v 1 -c <COMMUNITY_STRING> -ObentU localhost:161 1.3
sudo datadog-agent snmp walk localhost:161 1.3 -C <COMMUNITY_STRING>
```

## SNMP Metrics Should begin Populating in Network Devices UI
