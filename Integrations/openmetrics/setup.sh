
#!/bin/bash

# in order to cooperate with the AWS Sandbox environment, let's make sure to
# always rely on the ~/ directory for unix systems
. ~/.sandbox.conf.sh

echo "Provisioning!"
echo "apt-get updating"
sudo apt-get update upgrade -y
echo "install curl if not there..."
sudo apt-get install -y curl

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."

DD_API_KEY=${DD_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

echo "Adding Agent Configs to dd-agent"
sudo sed -i "s/# hostname: mymachine.mydomain/hostname: $HOSTNAME_BASE.custom_check/g" /etc/datadog-agent/datadog.yaml
sudo sed -i "s/# tags: mytag, env:prod, role:database/tags: $TAG_DEFAULTS,tester:custom_check/g" /etc/datadog-agent/datadog.yaml
sudo cp /home/vagrant/data/conf.yaml /etc/datadog-agent/conf.d/openmetrics.d/

sudo /etc/init.d/datadog-agent stop
sudo /etc/init.d/datadog-agent start

echo "Next Steps"

echo " "
echo "Run command: sudo python3 -m http.server 8080
"
echo "Open new terminal (cmd + T)
"
echo "Run command: curl http://127.0.0.1:8080/data/prometheus_exercise.txt
"