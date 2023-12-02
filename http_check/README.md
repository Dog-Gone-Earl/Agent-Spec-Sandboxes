# HTTP Check Integration
- <link>https://datadoghq.atlassian.net/wiki/spaces/TS/pages/328631451/SSL+TLS+Basics+and+Self+Signed+Certificates</link>
- <link>https://gist.github.com/fanny-jiang/082d125428828205cb1092b96de91e64</link>

## Run Command:

#### \*\*NOTE: Default certificate expiration is set to 500 days. To change edit in `cert_script.sh` script\*\*: 


```
-days 500
```

```
cd /etc; sudo mkdir http_sanbox; cd http_sanbox;
curl -o ssl-tls.md https://gist.githubusercontent.com/fanny-jiang/082d125428828205cb1092b96de91e64/raw/3df61cb880df51188b59d42d9beaaecb4298d4c2/ssl-tls.md;
bash ~/data/cert_script.sh ;sudo chmod 777 rootCA.key ubuntu.crt ubuntu.key
```

#### \*\*Take Note of `http` and `curl` Commands Outputted that will be Needed to Run Test\*\*:

### Open a second terminal: (cmd+T)
### Go to `/etc/sandbox_certs` directory: 

```
cd /etc/sandbox_certs
```

### Run `http-server` command from `bash` script output in one terminal to start server:

```
http-server -S -C <CLIENT_CERTIFICATE> -K <CLIENT_PRIVATE_KEY> -a '<HOSTNAME>' . -p 8080
```

### Can test with a `curl` command from `bash` script output in the other terminal:
#### - Look for `200` response
```
curl --cacert <ROOT_CA_CERT> https://<HOSTNAME>:8080
```

# Configuring the Agent HTTP_Check Integration:

### Create and Edit the `conf.d/http_check/conf.yaml` file
```
sudo cp -r /etc/datadog-agent/conf.d/http_check.d/conf.yaml.example /etc/datadog-agent/conf.d/http_check.d/conf.yaml
```

```
init_config:

instances:
  - name: <VALUE>
    url: https://ubuntu:8080/ssl-tls.md
    check_certificate_expiration: true
    tls_cert: /etc/sandbox_certs/ubuntu.crt
    tls_private_key: /etc/sandbox_certs/ubuntu.key
    tls_ca_cert: /etc/sandbox_certs/rootCA.crt    
```

## Restart Agent:

```
sudo service datadog-agent restart
```

## HTTP_Check Metrics Should Begin to Populate. 
### - You can `import` custom http_check dashboard `http_c.json` to see all metrics to include ssl expiration data:


