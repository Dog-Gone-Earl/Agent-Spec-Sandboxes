# Gunicorn (Host)

## 1. Spin Up Sandbox:
```
./run.sh up;
./run.sh ssh
```
## 2. Run command: 

```
gunicorn --workers=2 app:app --statsd-host localhost:8125 -n app
```

## 3. Open new terminal `(CMD+T)`
- ### 3a. `ssh` into sandbox (`./run.sh ssh`)
- ### 3b. Copy and Configure `gunicorn.d/conf.yaml` file: 

```
sudo cp -r /etc/datadog-agent/conf.d/gunicorn.d/conf.yaml.example /etc/datadog-agent/conf.d/gunicorn.d/conf.yaml
```

```
init_config:

instances:
    ## @param proc_name - string - required
    ## The name of the gunicorn process. For the following gunicorn server:
    ##
    ## gunicorn --name <WEB_APP_NAME> <WEB_APP_CONFIG>.ini
    ##
    ## the name is `<WEB_APP_NAME>`
  - proc_name: app

```

```
sudo sed -i "s/<PROC_NAME>/app/1" /etc/datadog-agent/conf.d/gunicorn.d/conf.yaml
```

## Restart Agent

```
sudo service datadog-agent restart
```
 
## Agent should show connection to Gunicorn Enviornment

