# Lighthouse Integration `CentOS`

- <link>https://docs.datadoghq.com/agent/guide/integration-management/?tab=linux#install</link>
- <link>https://docs.datadoghq.com/integrations/lighthouse/</link>

## Start sandbox
<pre>
  ./run.sh up;
  ./run.sh ssh
</pre>

## Install Lighthouse Integration Version:

`sudo datadog-agent integration install -t -r datadog-lighthouse==<LIGHTHOUSE_VERSION>`

## Restart Agent Service:

`sudo service datadog-agent restart`

## Copy Default Lighthouse `conf.yaml`` file:
`sudo cp -r /etc/datadog-agent/conf.d/lighthouse.d/conf.yaml.example /etc/datadog-agent/conf.d/lighthouse.d/conf.yaml`

## Configure Lighthouse Integration `yaml` File:

<pre>
init_config:

instances:
  - min_collection_interval: 60
    url: https://www.datadoghq.com
    name: <VALUE>
    extra_chrome_flags:
      - "--no-sandbox"
</pre>
## Restart Agent Service:

`sudo service datadog-agent restart`

## Lighthouse Metrics Should Begin to Collect
