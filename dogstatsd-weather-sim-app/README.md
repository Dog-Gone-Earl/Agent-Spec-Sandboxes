# dogstatsd-weather-sim-app

## Dogstatsd Excercise

### 1. Spin Up Ubuntu Sandbox

```
vagrant up
vagrant ssh
```
### 2. Install Agent on Ubuntu Sandbox
```
DD_API_KEY={DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
```

### 3. Install `pip` and `datadog` packages

```
sudo apt install python3-pip -y
pip3 install datadog
```

### 4. Enable Dogstatsd Paramters
<link>https://docs.datadoghq.com/developers/dogstatsd/?tab=hostagent&code-lang=python#agent</link>

```
sudo sed -i "s/# use_dogstatsd: true/use_dogstatsd: true/1" /etc/datadog-agent/datadog.yaml
```

### 5. Run `curl` command to grab .sh script:

```
curl -o weather.py https://raw.githubusercontent.com/Dog-Gone-Earl/Agent-Spec-Sandboxes/main/dogstatsd-weather-sim-app/weather_code.py
```

### 4. Restart the Agent
```
sudo systemctl restart datadog-agent
sudo datadog-agent status | grep "use_dogstatsd:"
```
### 5. Run Python program in the background:

```
python3 weather.py &
```

### 6. Go to your Datadg account. You should be able to search a list of 'weather.py' application metrics from code:

![image](https://user-images.githubusercontent.com/107069502/212426051-f315685b-5032-460c-befc-e80f8b78d755.png)

### 7. Close Weather App and Agent</h1>

```
 #PID number will display when starting Weather App
kill [PID]
sudo systemtctl stop datadog-agent
```
