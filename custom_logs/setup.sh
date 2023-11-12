#!/bin/bash

# in order to cooperate with the AWS Sandbox environment, let's make sure to
# always rely on the ~/ directory for unix systems
. ~/.sandbox.conf.sh

echo "Provisioning!"
echo ""

echo "apt-get updating"
#sudo apt-get update -y
#sudo apt-get upgrade -y
echo "install curl if not there..."
#sudo apt-get install -y curl

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

sudo mv /home/vagrant/data/{python_logs.py,conf.yaml} ~/
sudo mkdir /etc/datadog-agent/python_logs
sudo touch /etc/datadog-agent/python_logs/data.log
sudo chmod -R o+rwx /etc/datadog-agent/python_logs/data.log
sudo mkdir /etc/datadog-agent/conf.d/python_logger.d
sudo mv ~/conf.yaml /etc/datadog-agent/conf.d/python_logger.d
sudo chmod o+rx /etc/datadog-agent/conf.d/python_logger.d/conf.yaml