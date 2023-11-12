#!/bin/bash

echo "Updates and Initial Install"

sudo apt update -y && sudo apt upgrade -y

#install pyenv
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-all-dev git \
unixodbc unixodbc-dev tdsodbc libunwind-dev liblz4-dev python-pip pipx 

echo "Install Pyenv"
curl -s https://pyenv.run | bash

sudo sed -i '1 i\eval "$(pyenv init --path)"' ~/.bashrc
sudo sed -i '1 i\command -v pyenv >/dev/null' ~/.bashrc
sudo sed -i '1 i\export PATH="$PYENV_ROOT/bin:$PATH"' ~/.bashrc
sudo sed -i '1 i\export PYENV_ROOT="$HOME/.pyenv"' ~/.bashrc
sudo sed -i '1 i\eval "$(pyenv virtualenv-init -)"' ~/.bashrc

source ~/.bashrc

echo "Install python, penv versions, pip, pipx"

#install python 3.9.0 UPDATED 6/29
pyenv update
pyenv install 3.9.0
pyenv global 3.9.0

python -m pip install --user pipx
export PATH="$PATH:$HOME/.local/bin"
source ~/.bashrc
pip install --upgrade pip
pip install psutil
sudo apt update -y && sudo apt upgrade -y
sudo apt-get install -y python3-pip
python3 -m pip install memray

echo "
Install Inegrations Core and Extras"

git clone https://github.com/DataDog/integrations-core.git
git clone https://github.com/DataDog/integrations-extras.git

sudo mkdir integrations
sudo mv {integrations-core,integrations-extras} integrations

echo "
Docker Install"

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER
rm -r get-docker.sh

#updated to use ddev. UPDATED 6/29
#porting over all the functionality of datadog_checks_dev into ddev
#datadog_checks_dev won’t have ddev command anymore
echo "
Installing ddev"

pipx install ddev

echo "
Setting Ingegrations Paths"

ddev config set repos.core /home/vagrant/integrations/integrations-core/
ddev config set repos.extras /home/vagrant/integrations/integrations-extras/

echo "
Completed!"
