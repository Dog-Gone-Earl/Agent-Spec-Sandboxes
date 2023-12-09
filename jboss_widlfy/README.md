# jboss_widfly

# sandbox/vagrant/agent7

## What this VM does

- Spins up Jboss/Widly on sandbox

## VM type: os_or_distribution

- hajowieland/ubuntu-jammy-arm

## Special Instructions

### Run 
```
sudo chmod 770 run.sh; ./run.sh up; ./run.sh ssh
```

### 1. Once completed run script to setup jboss/wildfly Admin user
```
sudo /opt/wildfly/bin/add-user.sh
``` 

### 2. Enter `a` to begin configuring jboss/wildfly user

### 3. Enter `user` and `password` for logging into to jboss/wildfly

### 4. Select `enter` and type `yes` in prompts

### Can confirm ports `8080` and `9990` are open with commands

```
ss -tunelp | grep 8080

ss -tunelp | grep 9990
```

### 5. Run script to setup the `user` and `password` in jboss/wildfly `.yaml` file
- Also sets `/opt/wildfly/bin/` to your `$PATH` to run WildFly scripts from your current shell session
```
bash ~/data/jboss_user.sh ;source ~/.bashrc
```

#### - Can run command to login to jboss/wildfly
```
jboss-cli.sh --connect
```
#### - Type in version to see application information

```
version
```

#### - Can also check status with the command
```
sudo systemctl status wildfly
```
### *Can check if jboss instance running with `curl` command*:

```
curl localhost:8080
```
### 6. Check Agent status
```
sudo datadog-agent status
```

### Agent will recognize jboss/wildfly integration, enable OOTB dashboard, service check and logs.

### Have the Agent Tail Older jboss/wildfly Initialization logs
```
sudo cp /opt/wildfly/standalone/log/server.log /opt/wildfly/standalone/log/server2.log
```

# Future Update
- Deploy Java quickstart application to generate metrics





