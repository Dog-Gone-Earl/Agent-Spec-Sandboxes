#!/bin/bash

comm_string=<VALUE>

. ~/.sandbox.conf.sh

echo "Provisioning!"
echo ""

echo "apt-get updating"
sudo apt-get update -y
sudo apt-get upgrade -y
echo "install curl if not there..."
sudo apt-get install -y curl
sudo apt-get install snmpd snmp -y

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
sudo systemctl stop datadog-agent

sudo sed -i.yaml "s/# env: <environment name>/env: snmp_dev/1" /etc/datadog-agent/datadog.yaml

sudo cp -r /etc/datadog-agent/conf.d/snmp.d/conf.yaml.example /etc/datadog-agent/conf.d/snmp.d/conf.yaml
#sudo sed -i '73i rocommunity '${comm_string}'' /etc/snmp/snmpd.conf
sudo sed -i '73i rocommunity '$comm_string'' /etc/snmp/snmpd.conf

sudo sed -i "s/agentaddress  127.0.0.1,[::1]/agentAddress udp:161,udp6:[::1]:161/1" /etc/snmp/snmpd.conf
sudo sed -i "s/    # ip_address: <IP_ADDRESS>/    ip_address: '127.0.0.1'/1" /etc/datadog-agent/conf.d/snmp.d/conf.yaml
sudo sed -i "s/    # community_string: <COMMUNITY_STRING>/    community_string: '$comm_string'/1" /etc/datadog-agent/conf.d/snmp.d/conf.yaml
sudo sed -i "s/    # tags:/    tags:/1" /etc/datadog-agent/conf.d/snmp.d/conf.yaml
sudo sed -i "s/    #   - <KEY_1>:<VALUE_1>/      - Org:datadog/1" /etc/datadog-agent/conf.d/snmp.d/conf.yaml
sudo service snmpd restart
