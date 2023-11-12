## Custom Logs

<pre>./run.sh up; ./run.sh ssh</pre>

## Make directory and log file:
<pre>sudo mkdir /etc/datadog-agent/my_logs;

 sudo touch /etc/datadog-agent/my_logs/datadog.log
</pre>

## Set permissions for Agent to tail directory:
<pre>sudo chmod -R o+rwx /etc/datadog-agent/my_logs/datadog.log</pre>

## Create `conf.yaml` file and set permissions:
<pre>sudo mkdir /etc/datadog-agent/conf.d/custom_logs.d; 
sudo touch /etc/datadog-agent/conf.d/custom_logs.d/conf.yaml; 
sudo chmod o+rx /etc/datadog-agent/conf.d/custom_logs.d/conf.yaml
</pre>

## Input in the `conf.yaml` file:
logs:
  - type: file
    path: /etc/datadog-agent/my_logs/datadog.log
    service: bash_echo
    source: vagrant_ubuntu

</pre>

## Let us use the `sed` command to enable logs and verify with grep:
<pre>sudo sed -i "s/# logs_enabled: false/logs_enabled: true/1" /etc/datadog-agent/datadog.yaml
sudo cat /etc/datadog-agent/datadog.yaml | grep logs_enabled:
</pre>

## Restart Agetn
<pre>sudo service datadog-agent restart</pre>

## Send logs to `datadog.log` file
<pre>sudo echo {"Name": "Datadog", "Team": "Agent", "Message": "Can I get a flare ticket #$RANDOM?"} >> /etc/datadog-agent/my_logs/datadog.log</pre>

## Logs Scrubbing and Filtering

### ABC Car Dealership has their logs coming into datadog but not to filter some logs and information being sent to Dataog

- Filter all logs from the spy company `MI6`
- Scrub the `values` for the key `Price` from the `Company: Logans Logistics`

<link>https://regex101.com/r/XOUv6Y/1</link>