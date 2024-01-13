#!/bin/bash

# in order to cooperate with the AWS Sandbox environment, let's make sure to
# always rely on the ~/ directory for unix systems
. ~/.sandbox.conf.sh

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y socket

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"


sudo cp -r ~/data/port_open.py /etc/datadog-agent/checks.d/
sudo cp -r ~/data/port_open.yaml /etc/datadog-agent/conf.d/port_open.yaml
