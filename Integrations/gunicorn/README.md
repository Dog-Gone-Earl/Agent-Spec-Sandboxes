# Gunicorn (Host)

## 1. Spin Up Sandbox:
```
./run.sh up;
./run.sh ssh
```
## 2. Run command: 

```
gunicorn --workers=2 app:app --statsd-host localhost:8125 -n <APP_NAME>
```
- Replace `<APP_NAME>` with desired name

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
  - proc_name: <APP_NAME>

```
- Replace `<APP_NAME>` with set app name

## Restart Agent

```
sudo service datadog-agent restart
```
 
## Agent should show connection to Gunicorn Enviornment and generating metric `gunicorn.workers`

```
    gunicorn (4.0.0)
    ----------------
      Instance ID: gunicorn:f0ad747feb3240d6 [WARNING]
      Configuration Source: file:/etc/datadog-agent/conf.d/gunicorn.d/conf.yaml
      Total Runs: 43
      Metric Samples: Last Run: 2, Total: 22
      Events: Last Run: 0, Total: 0
      Service Checks: Last Run: 1, Total: 43
      Average Execution Time : 88ms
      Last Execution Date : 2024-12-26 21:31:08 CET / 2024-12-26 20:31:08 UTC (1735245068000)
      Last Successful Execution Date : 2024-12-26 21:31:08 CET / 2024-12-26 20:31:08 UTC (1735245068000)
      metadata:
        version.major: 23
        version.minor: 0
        version.patch: 0
        version.raw: 23.0.0
        version.scheme: semver
```

