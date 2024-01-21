#!/bin/bash

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

sudo sed -i.yaml "s/# hostname: <HOSTNAME_NAME>/hostname: bash_secrets/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# env: <environment name>/env: vagrant/1" /etc/datadog-agent/datadog.yaml

echo "alias dd_start='sudo systemctl start datadog-agent'">>~/.bashrc
echo "alias dd_stop='sudo systemctl stop datadog-agent'">>~/.bashrc
echo "alias dd_restart='sudo systemctl start datadog-agent && sudo systemctl stop datadog-agent'">>~/.bashrc
echo "alias dd_status='sudo datadog-agent status'">>~/.bashrc
source ~/.bashrc

