#!/bin/bash

# in order to cooperate with the AWS Sandbox environment, let's make sure to
# always rely on the ~/ directory for unix systems
. ~/.sandbox.conf.sh

echo "Provisioning!"

echo "apt-get updating"
sudo apt-get update -y
sudo apt-get upgrade -y
apt-get update  -y
echo "install curl if not there..."
apt-get install -y curl

sudo apt install python3-pip -y

pip install datadog-api-client

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

echo "Adding Agent Configs to dd-agent"

sudo sed -i.yaml "s/# hostname: <HOSTNAME_NAME>/hostname: $HOSTNAME/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# env: <environment name>/env: api_sandbox/1" /etc/datadog-agent/datadog.yaml


sudo /etc/init.d/datadog-agent stop
sudo /etc/init.d/datadog-agent start

echo "alias dd_start='sudo systemctl start datadog-agent'">>~/.bashrc
echo "alias dd_stop='sudo systemctl stop datadog-agent'">>~/.bashrc
echo "alias dd_restart='sudo systemctl start datadog-agent && sudo systemctl stop datadog-agent'">>~/.bashrc
echo "alias dd_status='sudo datadog-agent status'">>~/.bashrc
source ~/.bashrc