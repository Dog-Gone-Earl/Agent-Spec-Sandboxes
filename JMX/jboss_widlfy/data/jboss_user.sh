#!bin/bash

#https://computingforgeeks.com/install-wildfly-application-server-on-ubuntu-debian/?expand_article=1

sudo cp /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml.example /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml

jboss_user=$1
jboss_password=$2

sudo cat >> ~/.bashrc <<EOF
export WildFly_BIN="/opt/wildfly/bin/"
export PATH=\$PATH:\$WildFly_BIN
EOF

source ~/.bashrc

echo "Please enter Jboss/Wildfly Admin username used in confiuration:
"
read jboss_user

echo "
Please enter Jboss/Wildfly Admin password:
"
read jboss_password

echo "Configuring jboss/wildfly with Agent
"
sleep 3

sudo sed -i "s/    # user: <USER>/    user: $jboss_user/1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s/    # password: <PASSWORD>/    password: $jboss_password/1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s/    # custom_jar_paths:/    custom_jar_paths:/1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s|\    #   - /path/to/jboss-cli-client.jar|      - /opt/wildfly/bin/client/jboss-cli-client.jar|1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s|\    # name: <NAME>|    name: jboss-application|1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s/# logs_enabled: false/logs_enabled: true/1" /etc/datadog-agent/datadog.yaml

echo "Enable jboss/wildfly logs
"
sleep 3

sudo chmod 755 /opt/wildfly/standalone/log/{audit.log,server.log}
sudo sed -i "s|\# logs:|logs:|1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s|\#   - type: file|  - type: file|1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s|#     path: \/opt\/jboss/wildfly\/standalone\/log\/\*.log|    path: /opt/wildfly/standalone/log/*.log|1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s|\#     source: jboss_wildfly|    source: jboss_wildfly|1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml
sudo sed -i "s|\#     service: <SERVICE_NAME>|    service: ubuntu_jboss|1" /etc/datadog-agent/conf.d/jboss_wildfly.d/conf.yaml

###############WIP Generate Metrics#################

sudo apt-get install unzip -y ; sudo apt install maven -y
sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.5/source/apache-maven-3.9.5-src.zip
unzip apache-maven-3.9.5-src.zip
sudo https://github.com/jboss-developer/jboss-eap-quickstarts.git
sudo sudo apt install openjdk-8-jdk -y
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64
export PATH=$PATH:$JAVA_HOME/bin

###############Jboss Quickstart example#############
#(https://github.com/jboss-developer/jboss-eap-quickstarts)
#git clone https://github.com/jboss-developer/jboss-eap-quickstarts
#cd /jboss-eap-quickstarts/kitchensink
#mvn verify (in kitchensink dir)
#mvn clean install jboss:deploy (in kitchensink dir)
# OR
#mvn clean install wildfly:deploy (in kitchensink dir)
#

sudo systemctl restart datadog-agent

echo "
User and password set!"
