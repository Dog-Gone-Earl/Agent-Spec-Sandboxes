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
<pre>
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

## Restart Agent
<pre>sudo service datadog-agent restart</pre>

## Send logs to `datadog.log` file
<pre>sudo echo {"Name": "Datadog", "Team": "Agent", "Message": "Can I get a flare ticket #$RANDOM?"} >> /etc/datadog-agent/my_logs/datadog.log</pre>

# Logs Scrubbing and Filtering
<link>https://docs.datadoghq.com/agent/logs/advanced_log_collection/?tab=configurationfile#filter-logs</link>

### ABC Car Dealership has their logs coming into Datadog but require not to filter some logs and information being sent:

- Filter all logs from the spy `Company: MI6`
- Scrub the `values` for the key `Price` from the `Company: Logans Logistics`

## Pyhton App Will Simulate Logs Scrubbing/Filtering from `conf.d/python_logger.d/conf.yaml` configuration file:

<pre>
logs:
  - type: file
    path: /etc/datadog-agent/python_logs/data.log
    service: python_app
    source: python
    log_processing_rules:
    - type: exclude_at_match
      name: exclude_mi6
      ## Regexp can be anything
      pattern: (MI6)
    - type: mask_sequences
      name: price_hide
      replace_placeholder: "$1 $2 $3 $4 $5 masked_price"
      ##One pattern that contains capture groups
      pattern: ('Company':)\s('Logans Logistics').*('Item':)\s('Van', |'SUV', |'Truck', )('Price':)\s(\d{5})
</pre>

<pre>python3 python_logs.py
 
CTRL+C #stop app
</pre>
