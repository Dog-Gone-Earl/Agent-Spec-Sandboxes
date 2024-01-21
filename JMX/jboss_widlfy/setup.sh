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

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

echo "Installing jboss/wildfly components
"
sleep 3
sudo apt update
sudo apt -y install default-jdk
sudo apt install curl wget
WILDFLY_RELEASE=$(curl -s https://api.github.com/repos/wildfly/wildfly/releases/latest|grep tag_name|cut -d '"' -f 4)
sudo wget https://github.com/wildfly/wildfly/releases/download/${WILDFLY_RELEASE}/wildfly-${WILDFLY_RELEASE}.tar.gz
sudo tar xvf wildfly-${WILDFLY_RELEASE}.tar.gz
sudo mv wildfly-${WILDFLY_RELEASE} /opt/wildfly
sudo groupadd --system wildfly
sudo useradd -s /sbin/nologin --system -d /opt/wildfly  -g wildfly wildfly
sudo mkdir /etc/wildfly
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo chown -R wildfly:wildfly /opt/wildfly
sudo systemctl daemon-reload
sudo systemctl start wildfly && sudo systemctl enable wildfly
sudo chmod o+rx /opt/wildfly/bin/client/jboss-cli-client.jar
sudo sed -i.yaml "s/# hostname: <HOSTNAME_NAME>/hostname: jboss_wildfly_sandbox/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# env: <environment name>/env: jbosswildfly_ubuntu/1" /etc/datadog-agent/datadog.yaml
sudo /etc/init.d/datadog-agent stop

echo "Jboss/Wildly Sandbox Deployed!"
