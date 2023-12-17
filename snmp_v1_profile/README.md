# SNMP V1 Profile

## Set Your `community string` value in the `setup.sh` File:
```
comm_string=<VALUE>
```

## Start the sandbox:
```
./run.sh up;
.run.sh ssh;
```

## Create a .yaml file in `/etc/datadog-agent/conf.d/snmp.d/profiles/<FILENAME>.yaml file`:

```
sudo touch /etc/datadog-agent/conf.d/snmp.d/profiles/ubuntu.yaml
```

## Input in `ubuntu.yaml` file:

```
sysobjectid: 1.3.6.1.4.1.8072.3.2.10
metrics:
  - symbol:
      OID: 1.3.6.1.2.1.31.1.1.1.15.2
      name: <NAME>_ifHighSpeed
```
## - Can also wildcard the `sysobjectid`:

```
Example
1.3.*
```
### Will be targeting ubuntu snmp `OID` that exposes the `sysobjectid`:

```
.1.3.6.1.4.1.8072.3.2.10
.1.3.6.1.2.1.1.2.0 = OID: .1.3.6.1.4.1.8072.3.2.10
```

### Agent polls this OID from `_base.yml` profile:
- <link>https://github.com/DataDog/integrations-core/blob/master/snmp/datadog_checks/snmp/data/default_profiles/_base.yaml#L19C1-L22C28</link>
### - Test with `snmpwalk`:

```
snmpwalk -v 1 -c <COMMUNITY_STRING> -ObentU localhost:161 .1.3.6.1.2.1.1.2.0
```

## We will target the OID `ifHighSpeed`:
### - Test with `snmpwalk`:
- Defined as "An estimate of the interface's current bandwidth in units of 1,000,000 bits per second"
- <link>https://oidref.com/1.3.6.1.2.1.31.1.1.1.15</link>

```
snmpwalk -v 1 -c <COMMUNITY_STRING> -ObentU localhost:161 .1.3.6.1.2.1.31.1.1.1.15.2
```

## Output:
```
.1.3.6.1.2.1.31.1.1.1.15.2 = Gauge32: 10000
```

## Set `profile` value to `ubuntu` to have Agent to use only `profile`` configuratin:

```
profile: ubuntu
```

## Change owner of file to `dd-agent`:

```
sudo chown dd-agent /etc/datadog-agent/conf.d/snmp.d/profiles/ubuntu.yaml
```

- Good verification to make with customer. Can see in flare from `permissions.log` file. Needs a minimum `read` permissions:

```
/etc/datadog-agent/conf.d/snmp.d/profiles/ubuntu.yaml | -rw-rw-r-- | dd-agent   | root       |           |
```

### Start Agent:

```
sudo service datadog-agent start
```
## You Should be able to query configured snmp metric `<NAME>_ifHighSpeed`:

```
max:snmp.<NAME>_ifHighSpeed{*} by {snmp_profile}
```

## Value should match `value` from `snmpwalk` output value `10000`

## Next Steps:
Try building your own profile with the [snmp_v3](https://github.com/Dog-Gone-Earl/Agent-Spec-Sandboxes/tree/main/snmp_v3) sandbox!
