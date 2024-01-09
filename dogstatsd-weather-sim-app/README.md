# dogstatsd-weather-sim-app

## Dogstatsd Excercise

### 1. Install Agent on Ubuntu Sandbox
### 2. Install packages:

### 3. Install pip and Datadog packages

```
sudo apt install python3-pip -y
pip3 install datadog
```

### 4. Enable Dogstatsd Paramters
<link>https://docs.datadoghq.com/developers/dogstatsd/?tab=hostagent&code-lang=python#agent</link>

### 5. Run `curl` command to grab .sh script:

```
curl -o weather_code.py https://raw.githubusercontent.com/Dog-Gone-Earl/Agent-Spec-Sandboxes/main/dogstatsd-weather-sim-app/weather_code.py
```

### 4. Restart the Agent
```
sudo systemctl restart datadog-agent
```
### 5. Run Python program in the background:

```
python3 weather_code.py &
```

### 6. Go to your Datadg account. You should be able to search a list of 'weather.py' application metrics from code:

![image](https://user-images.githubusercontent.com/107069502/212426051-f315685b-5032-460c-befc-e80f8b78d755.png)

### 7. Close Weather App and Agent</h1>

```
 #PID number will display when starting Weather App
kill [PID]
sudo systemtctl stop datadog-agent
```
