# Openmetrics (Host)

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
- ### 3b. Configure `gunicorn.d/yaml` file: 

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

## Restart Agent

```
sudo service datadog-agent restart
```
 
## Openmetrics KB Reference of Implemenation:
