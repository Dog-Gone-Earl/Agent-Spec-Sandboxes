#!/bin/bash

#Configuration of Environment Variables
database=weather_database
table=weather_table
user=root
datadog_user=<AGENT_USER>
datadog_pw=<AGENT_PASSWORD>
mysql_user=<MYSQL_USER>
mysql_user_pw=<MYSQL_PASSWORD>

# in order to cooperate with the AWS Sandbox environment, let's make sure to
# always rely on the ~/ directory for unix systems
. ~/.sandbox.conf.sh

echo "Provisioning!"
echo ""
echo "apt-get updating"
sudo apt-get update -y
sudo apt-get upgrade -y
echo "install curl if not there..."
sudo apt-get install -y curl

#set environment variable for mysql password
echo "Setting environment varialbe for mysql"
echo ""
sudo chmod 777 /etc/environment
sudo echo "MYSQL_USER=$mysql_user" >> /etc/environment
sudo echo "MYSQL_PW=$mysql_user_pw" >> /etc/environment

#Installing pip, Python, and datadog modules"
echo "Installing pip and Python datadog module"
echo ""
sleep 3
sudo apt-get install python3.7 -y
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
sudo -H apt-get install python3-pip -y
sudo -h $HOSTNAME pip3 install datadog
python3 -m pip install --upgrade pip
sudo -u root pip3 install datadog

#mysql install components
echo "Mysql install and configuration of database"
echo ""
sleep 3
sudo apt-get install mysql-server -y
sudo pip3 install mysql-connector-python
sudo mysql --user=$user --execute="CREATE DATABASE $database; USE $database; CREATE TABLE $table (temp INT(3), humidity INT(3), pressure INT(4)); "
sudo mysql --user=$user --execute="CREATE USER '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_user_pw'; GRANT ALL ON *.* TO '$mysql_user'@'localhost'; FLUSH PRIVILEGES;"
sudo mysql --user=$user --execute="CREATE USER '$datadog_user'@'%' IDENTIFIED WITH mysql_native_password by '$datadog_pw'; ALTER USER $datadog_user@'%' WITH MAX_USER_CONNECTIONS 5; GRANT REPLICATION CLIENT ON *.* TO $datadog_user@'%';GRANT PROCESS ON *.* TO $datadog_user@'%';"
sudo mysql --user=$user --execute="GRANT SELECT ON performance_schema.* TO $datadog_user@'%'; CREATE SCHEMA IF NOT EXISTS $datadog_user;"
sudo mysql --user=$user --execute="GRANT EXECUTE ON $datadog_user.* to $datadog_user@'%'; GRANT CREATE TEMPORARY TABLES ON $datadog_user.* TO $datadog_user@'%';"

sudo mysql --user=$user --execute="DELIMITER $$
CREATE PROCEDURE $datadog_user.explain_statement(IN query TEXT)
    SQL SECURITY DEFINER
BEGIN
    SET @explain := CONCAT('EXPLAIN FORMAT=json ', query);
    PREPARE stmt FROM @explain;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ; "

sudo mysql --user=$user --execute="DELIMITER $$
CREATE PROCEDURE $datadog_user.enable_events_statements_consumers()
    SQL SECURITY DEFINER
BEGIN
    UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name LIKE 'events_statements_%';
    UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name = 'events_waits_current';
END $$
DELIMITER ;"

sudo mysql --user=$user --execute="GRANT EXECUTE ON PROCEDURE $datadog_user.enable_events_statements_consumers TO $datadog_user@'%';"

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

echo "Adding Agent Configs to dd-agent"
echo ""

sudo sed -i.yaml "s/# hostname: <HOSTNAME_NAME>/hostname: jammy_ubuntu/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# env: <environment name>/env: mysql_sandbox/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# use_dogstatsd: true/use_dogstatsd: true/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# dogstatsd_port: 8125/dogstatsd_port: 8125/1" /etc/datadog-agent/datadog.yaml

echo "Adding Configs to Mysql Yaml File"
echo ""
sudo cp -R "/home/vagrant/data/conf.yaml" "/etc/datadog-agent/conf.d/mysql.d/conf.yaml"
sudo sed -i "s/    username: datadog/    username: $datadog_user/1" /etc/datadog-agent/conf.d/mysql.d/conf.yaml
sudo sed -i "s/    password: <PASSWORD>/    password: $datadog_pw/1" /etc/datadog-agent/conf.d/mysql.d/conf.yaml
sudo sed -i "s/    # dbm: false:/    dbm: true/1" /etc/datadog-agent/conf.d/mysql.d/conf.yaml
sudo chmod o+rx /etc/datadog-agent/conf.d/mysql.d/conf.yaml

sudo /etc/init.d/datadog-agent stop

echo "Retrieving Python file"
echo ""
sleep 3
sudo cp -R "/home/vagrant/data/weather.py" "/home/vagrant"
sudo chmod o+rx ~/weather.py 

sudo systemctl stop datadog-agent
sudo systemctl restart datadog-agent
sleep 10
sudo systemctl restart datadog-agent
echo ""
echo "Dogstatsd/Mysql Completed!"
