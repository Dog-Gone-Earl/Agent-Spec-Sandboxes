# SNMMPV1

## Set the `community string` value in the 'setup.sh' file:
<code>comm_string=<VALUE></code>

## Start the Sandbox
<code>
./run.sh up;
.run.sh ssh;
</code>

## You should be able to Run agent/snmpwalk
<code>
snmpwalk -v 1 -c public -ObentU localhost:161 1.3
sudo datadog-agent snmp walk localhost:161 1.3 -C public
</code>