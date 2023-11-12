#!/bin/bash

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
sudo pip install python-dotenv

#Install Agent
echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

echo "Adding Agent Configs to dd-agent
"

#Set datadog.yaml information
sudo sed -i.yaml "s/# hostname: <HOSTNAME_NAME>/hostname: $HOSTNAME/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# env: <environment name>/env: vagrant_mysql/1" /etc/datadog-agent/datadog.yaml

#Set Permission of secrets script
sudo chmod 777 /etc/datadog-agent/
sudo mv /home/vagrant/data/mysql_password.py /etc/datadog-agent/
sudo chmod 700 /etc/datadog-agent/mysql_password.py
sudo chown dd-agent. /etc/datadog-agent/mysql_password.py 

#Set mysql Integration information
sudo cp /etc/datadog-agent/conf.d/mysql.d/conf.yaml.example /etc/datadog-agent/conf.d/mysql.d/conf.yaml
sudo sed -i.yaml "s/    username: datadog/    username: ENC[mysql_username]/1" /etc/datadog-agent/conf.d/mysql.d/conf.yaml
sudo sed -i.yaml "s/    password: <PASSWORD>/    password: ENC[mysql_password]/1" /etc/datadog-agent/conf.d/mysql.d/conf.yaml
sudo sed -i.yaml "s/    # dbm: false:/    dbm: true/1" /etc/datadog-agent/conf.d/mysql.d/conf.yaml
sudo sed -i.yaml "s|# secret_backend_command: <COMMAND_PATH>|secret_backend_command: /etc/datadog-agent/mysql_password.py|1" /etc/datadog-agent/datadog.yaml

echo "Installing pip and Python datadog module
"

sleep 3
sudo apt-get install python3.7 -y
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
sudo -H apt-get install python3-pip -y
python3 -m pip install --upgrade pip
  
echo "Mysql install
"

sleep 3
sudo apt-get install mysql-server -y
sudo pip3 install mysql-connector-python

#Run mysql Commands
echo "Running Mysql Commands...
"
sleep 3
sudo mysql --user='root' --execute="CREATE DATABASE weather_database; USE weather_database; CREATE TABLE weather_table (temp INT(3), humidity INT(3), pressure INT(4));"
sudo mysql --user='root' --execute="CREATE USER datadog@'%' IDENTIFIED WITH mysql_native_password by '<PASSWORD>'; ALTER USER datadog@'%' WITH MAX_USER_CONNECTIONS 5; GRANT REPLICATION CLIENT ON *.* TO datadog@'%';GRANT PROCESS ON *.* TO datadog@'%'; FLUSH PRIVILEGES;"
sudo mysql --user='root' --execute="GRANT SELECT ON performance_schema.* TO datadog@'%'; CREATE SCHEMA IF NOT EXISTS datadog;"
sudo mysql --user='root' --execute="GRANT EXECUTE ON datadog.* to datadog@'%'; GRANT CREATE TEMPORARY TABLES ON datadog.* TO datadog@'%';"

sudo mysql --user='root' --execute="DELIMITER $$
CREATE PROCEDURE datadog.explain_statement(IN query TEXT)
    SQL SECURITY DEFINER
BEGIN
    SET @explain := CONCAT('EXPLAIN FORMAT=json ', query);
    PREPARE stmt FROM @explain;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ; "

sudo mysql --user='root' --execute="DELIMITER $$
CREATE PROCEDURE datadog.enable_events_statements_consumers()
    SQL SECURITY DEFINER
BEGIN
    UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name LIKE 'events_statements_%';
    UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name = 'events_waits_current';
END $$
DELIMITER ;"

sudo mysql --user='root' --execute="GRANT EXECUTE ON PROCEDURE datadog.enable_events_statements_consumers TO datadog@'%';"

echo "Restarting Agent
"
sudo /etc/init.d/datadog-agent stop
sudo /etc/init.d/datadog-agent start
echo "Done!"
