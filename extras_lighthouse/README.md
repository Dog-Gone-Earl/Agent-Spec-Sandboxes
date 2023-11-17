# Lighthouse Integration `CentOS`

- <link>https://docs.datadoghq.com/agent/guide/integration-management/?tab=linux#install</link>
- <link>https://docs.datadoghq.com/integrations/lighthouse/</link>

## 1. Start sandbox
```
  ./run.sh up;
  ./run.sh ssh
```

## 2. Install Lighthouse Integration Version:

```
sudo datadog-agent integration install -t -r datadog-lighthouse==<LIGHTHOUSE_VERSION>
```

## 3. Restart Agent Service:

```
sudo service datadog-agent restart
```

## 4. Copy Default Lighthouse `conf.yaml`` file:
```
sudo cp -r /etc/datadog-agent/conf.d/lighthouse.d/conf.yaml.example /etc/datadog-agent/conf.d/lighthouse.d/conf.yaml
```

## 5. Configure Lighthouse Integration `yaml` File:

```
init_config:

instances:
  - min_collection_interval: 60
    url: https://www.datadoghq.com
    name: <VALUE>
    extra_chrome_flags:
      - "--no-sandbox"
```
## 6. Restart Agent Service:

```
sudo service datadog-agent restart
```

## Lighthouse Metrics Should Begin to Collect
