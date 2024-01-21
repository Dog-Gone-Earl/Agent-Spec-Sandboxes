#!/bin/bash
. ~/.sandbox.conf.sh

echo "alias dd_start='sudo systemctl start datadog-agent'">>~/.bashrc
echo "alias dd_stop='sudo systemctl stop datadog-agent'">>~/.bashrc
echo "alias dd_restart='sudo systemctl start datadog-agent && sudo systemctl stop datadog-agent'">>~/.bashrc
echo "alias dd_status='sudo datadog-agent status'">>~/.bashrc
source ~/.bashrc

sudo dnf check-update -y ; sudo dnf update -y

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
sudo sed -i "s/# hostname: <HOSTNAME_NAME>/hostname: centos/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# env: <environment name>/env: centOS_box/1" /etc/datadog-agent/datadog.yaml

sudo dnf module install nodejs:20/common -y
sudo npm install -g lighthouse -y
sudo yum install -y epel-release; sudo yum install -y chromium ; sudo dnf install nano -y