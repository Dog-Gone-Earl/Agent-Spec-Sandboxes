# Secrets Management for `datadog.yaml` file
- ## Will Test Configuring `API KEY` and `site` Parameters

## Create file:
<pre>cd /etc/datadog-agent/
sudo touch agent_secrets.sh 
</pre>

## Set Permissions:
```
sudo chmod 700 agent_secrets.sh>
sudo chown root agent_secrets.sh
```

## Input in `bash` script:
```
#!/bin/bash

printf printf '{"dd_api_key": {"value": “<DD_API_KEY>“, "error": null},"dd_site": {"value": "datadoghq.com", "error": null}}'
```
- ### Replace ```<DD_API_KEY>``` with API Key
  
## In `datadog.yaml` File:
### Set the values from bash file in `api_key` and `site` parameters
```api_key: ENC[dd_api_key]```

### Lets try with `sed`
`sudo sed -i.yaml "s|site: datadoghq.com|site: ENC[dd_site]|1" /etc/datadog-agent/datadog.yaml`

### Set path of bash executable

<pre>sudo sed -i.yaml "s|# secret_backend_command: <COMMAND_PATH>|secret_backend_command: /etc/datadog-agent/agent_secrets.sh|1" /etc/datadog-agent/datadog.yaml</pre>

## Restart Agent
```sudo service datadog-agent restart```

## Check Secrets with Agent commands:
<pre>
sudo datadog-agent secrets
sudo -u dd-agent -- datadog-agent configcheck
sudo -u dd-agent bash -c "echo '{\"version\": \"1.0\", \"secrets\": [\”dd_api_key\”, \”dd_site\”]}’ | /etc/datadog-agent/agent_secrets.sh ”
</pre>
