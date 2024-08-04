#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install python -y

wget -o flink-data.tgz https://dlcdn.apache.org/flink/flink-1.18.1/flink-1.18.1-bin-scala_2.12.tgz
tar -xzf flink-1.18.1-bin-scala_2.12.tgz 

sudo apt install default-jdk -y
sudo apt update
sudo apt install default-jre software-properties-common -y
sudo add-apt-repository ppa:linuxuprising/java
sudo apt install oracle-java17-installer -y
sudo apt-get update

