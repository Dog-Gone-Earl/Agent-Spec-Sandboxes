#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install python -y

wget -o flink-data.tgz https://dlcdn.apache.org/flink/flink-1.18.1/flink-1.18.1-bin-scala_2.12.tgz
tar -xzf flink-1.18.1-bin-scala_2.12.tgz 

sudo apt install default-jdk
sudo apt update;sudo apt install default-jre
sudo apt install software-properties-common
sudo add-apt-repository ppa:linuxuprising/java -y
sudo apt install oracle-java17-installer
sudo apt-get update

