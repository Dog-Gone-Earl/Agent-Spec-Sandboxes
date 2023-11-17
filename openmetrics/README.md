# Openmetrics (Host)

## 1. Spin Up Sandbox:
```
./run.sh up;
./run.sh ssh
```
## 2. Run command: 

```
sudo python3 -m http.server 8080
```

## 3. Open new terminal `(CMD+T)`
- ### 3a. `ssh` into sandbox (`./run.sh ssh`)
- ### 3b. Run `curl` Command on Openmetrics Data from Server Endpoint: 

```
curl http://127.0.0.1:8080/data/prometheus_exercise.txt
```

## Openmetrics KB Reference of Implemenation:
<link>https://datadoghq.atlassian.net/wiki/spaces/TS/pages/1653801630/Prometheus+Openmetrics+Hands-on+Troubleshooting+Prometheus+Payloads</link>
