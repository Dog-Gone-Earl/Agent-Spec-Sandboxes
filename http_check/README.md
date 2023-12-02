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

### Edit the `conf.d/http_check/conf.yaml` file

```
init_config:

instances:
  - name: <VALUE>
    url: https://ubuntu:8080/hello_cert.html
    check_certificate_expiration: true
    tls_cert: /etc/sandbox_certs/ubuntu.crt
    tls_private_key: /etc/sandbox_certs/ubuntu.key
    tls_ca_cert: /etc/sandbox_certs/rootCA.crt    
```

![image](https://github.com/Dog-Gone-Earl/Agent-Spec-Sandboxes/assets/107069502/d28b0b7e-e3de-4501-87a2-9f5b7b56a586)
![image](https://github.com/Dog-Gone-Earl/Agent-Spec-Sandboxes/assets/107069502/ade9d710-3343-42bc-9ce0-49ebc9bf87fe)

## Restart Agent:

```
sudo service datadog-agent restart
```

## HTTP_Check Metrics Should Begin to Populate. 
- You can copy and `import` a made Dashboard `http_c.json` file in `dashboard` folder to see metrics to include `ssl expiration` data.
