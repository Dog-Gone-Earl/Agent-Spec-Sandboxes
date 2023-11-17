# Dog-Gone-Earl/Secrets_Management

# What this VM does
## Datadog Mysql Connection with Secrets Management

<li>Live example of using Secrets Management with the Agent</li>
<li>Mysql Database will be created</li>
<li>Datadog Agent will be installed on Sandbox</li>
<li>Agent will collect <code>username/password</code> from Python executable <code>.py</code> file for Mysql Integration</li>

  
# VM type: Linux Jammy

# Special Instructions:

## 1. Open `setup.sh` file and set your ```"<PASSWORD>"``` for mysql command (`line 62`):

```
IDENTIFIED WITH mysql_native_password by '<PASSWORD>'
```

## 2. Open the `/data/mysql_password.py` file and set the PASSWORD used in previous step:

```
"value": <$PASSWORD>
```

## 3. Spin up the Sandbox:

```
chmod 770 run.sh && ./run.sh up
```

## 4. SSH into Sandbox:
```
./run.sh ssh
```
  
## 5. Confirm Secrets Being Used:

```
sudo datadog-agent secret
sudo datadog-agent configcheck
```

```
sudo -u dd-agent bash -c "echo '{\"version\": \"1.0\", \"secrets\": [\"mysql_username\", \"mysql_password\"]}' | /etc/datadog-agent/mysql_password.py"
```

## Verify Mysql Integration Status
```
sudo datadog-agent status | grep "[^_]mysql.*"
```

## Secrets Managaement Documentation:
<li><link>https://docs.datadoghq.com/agent/guide/secrets-management/?tab=linux#pagetitle</li></link>
<li><link>https://datadoghq.atlassian.net/wiki/spaces/TS/pages/887259347/Secrets+Management+How-To+s</li></link>
<li><link>https://datadoghq.atlassian.net/wiki/spaces/TS/pages/328436442/Using+secrets+management+on+Windows</li></link>
<li><link>https://datadoghq.atlassian.net/wiki/spaces/TS/pages/1141900074/How+to+use+Kubernetes+Secrets+for+Secrets+Management</li></link>
