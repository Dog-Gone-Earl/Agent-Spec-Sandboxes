# Mysql DBM

### <h3>Mysql DBM Metrics</h3>
- Based on [Python Weather App 1.0](https://datadoghq.atlassian.net/wiki/spaces/TS/pages/2789376418/Dogstatsd+Exercise+Python)<p></p>


### This VM will spin up a Ubuntu VM to run:
- Python Weather Application to simulate collecting temperature, humidity, and pressure values
- Mimicking raspberry pi Sense HAT functionality ([Sense HAT](https://www.raspberrypi.com/products/sense-hat/))
  - Agent collects Mysql metrcis and Mysql DBM metrics
- Using current version Agent 7

## VM type: Linux Ubuntu (hajowieland/ubuntu-jammy-arm)

## Special Instructions

- Make sure that both `api/app key` is in `~/.sandbox.conf.sh` file

### 1. Configure your `user` parameter in `setup.sh` file to `root`:
<pre>user=root</pre>

### 2. Configure your `datadog_user`,`datadog_pw`, `mysql_user`, and `mysql_user_pw` parameters in `setup.sh` file:

`datadog_user=<AGENT_USER>`

`datadog_pw=<AGENT_PASSWORD>`

`mysql_user=<MYSQL_USER>`

`mysql_user_pw=<MYSQL_PASSWORD>`

### 3. Run commands
<pre>./run.sh up
./run.sh ssh </pre>

### 4. Once sandbox is deployed, run command:

<pre>python3 weather.py</pre>

### Terminal output will be data being sent to Mysql database
-  `(temperature, humidity, pressure)`
-  Python metrics will generate every `.5` seconds so data at `10` second collection intervall (Dogstatsd default) will be represetned in Datadog (`~20th` value)

### 5. To stop Python app:
<pre>CTRL+C</pre>

### Check values in database:
<pre>sudo mysql -uroot -p

select * from weather_database.weather_table;

</pre>
