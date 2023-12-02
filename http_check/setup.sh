#!/bin/bash
date=$date

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

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

cd /tmp
sudo curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh
sudo chmod 500 nsolid_setup_deb.sh
sudo bash nsolid_setup_deb.sh 21
sudo apt-get install nodejs -y
sudo npm install --global http-server

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
sudo /etc/init.d/datadog-agent stop

sudo cp -r /etc/datadog-agent/conf.d/http_check.d/conf.yaml.example /etc/datadog-agent/conf.d/http_check.d/conf.yaml
sudo sed -i.yaml "s/# hostname: <HOSTNAME_NAME>/hostname: http_check_sandbox/1" /etc/datadog-agent/datadog.yaml
sudo sed -i.yaml "s/# env: <environment name>/env: ubuntu_land/1" /etc/datadog-agent/datadog.yaml
sudo /etc/init.d/datadog-agent start
echo "Sandbox Configured at $(date)!"
echo "Lets Work on the HTTP Configuration"