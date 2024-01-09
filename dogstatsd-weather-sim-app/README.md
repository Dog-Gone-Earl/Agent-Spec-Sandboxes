# dogstatsd-weather-sim-app
Dogstatsd Excercise
<h1><i>1. Install Agent on Ubuntu Sandbox</i><h1>
<h1><i>2. Enable Dogstatsd Paramters:</i></h1>
  <h1>3.(Choose your option)</h1>
  <li>Run 'eval' command:</li>
<pre>eval "$(curl https://raw.githubusercontent.com/Dog-Gone-Earl/dogstatsd-weather-sim-app/main/weather_script.sh)"</pre>
<h2>Or</h2>
<li>Run 'curl' command</li>
<pre>curl https://raw.githubusercontent.com/Dog-Gone-Earl/dogstatsd-weather-sim-app/main/weather_script.sh</pre>
<li>Run the script:</li>
<pre>weather_script.sh</pre>
  <h1>4. Restart the Agent</h1>
  <pre>sudo systemctl stop datadog-agent
sudo systemctl start datadog-agent</pre>
  <h1>5. Run Python program in the background:</h1>
  <pre>python3 weather_code.py &</pre>
  <h1>6. Go to your Datadg account. You should be able to search a list of 'weather.py' application metrics from code:</h1>

![image](https://user-images.githubusercontent.com/107069502/212426051-f315685b-5032-460c-befc-e80f8b78d755.png)

  <h1>Close Weather App and Agent</h1>
  <pre>#PID number will display when starting Weather App
kill [PID]
sudo systemtctl stop datadog-agent</pre>
  


