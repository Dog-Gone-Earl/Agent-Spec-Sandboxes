#!/bin/bash


# in order to cooperate with the AWS Sandbox environment, let's make sure to
# always rely on the ~/ directory for unix systems
. ~/.sandbox.conf.sh
DD_API_KEY=${DD_API_KEY}
echo "Provisioning!"
echo ""

echo "apt-get updating"
sudo apt-get update -y
sudo apt-get upgrade -y
echo "install curl if not there..."
sudo apt-get install -y curl wget systemctl

echo "Installing otel-collector with dd_api_key: ${DD_API_KEY}..."
echo "."; sleep 1; echo ".."; sleep 1; echo "..." ;sleep 1
wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.110.0/otelcol-contrib_0.110.0_linux_arm64.deb
sudo dpkg -i otelcol-contrib_0.110.0_linux_arm64.deb

#Setting up Datadog components...
echo -e "\nSetting up Datadog components..."
echo "."; sleep 1; echo ".."; sleep 1; echo "..." ;sleep 1
sudo cp -r /home/vagrant/shared/collector.yaml /etc/otelcol-contrib
sudo sed -i "s/config.yaml/collector.yaml/1" /etc/otelcol-contrib/otelcol-contrib.conf
sudo sed -i "s|\$DD_API_KEY|$DD_API_KEY|1" /etc/otelcol-contrib/collector.yaml
sudo chmod 777 /etc/environment 
sudo echo "DD_API_KEY=$DD_API_KEY" >> /etc/environment 

#Setting envars and restarting otel-collector service
echo -e "\nSetting envars and restarting otel-collector service..."
echo "."; sleep 1; echo ".."; sleep 1; echo "..." ;sleep 1
source /etc/environment 
sudo systemctl daemon-reload
sudo service otelcol-contrib restart