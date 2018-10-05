#!/bin/bash
set -e
echo -e "Installing MongoDB..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt-get update -qq && sudo apt-get install -y mongodb-org
echo -e "Starting MongoDB..."
sudo systemctl start mongod
sudo systemctl enable mongod
sleep 3
echo -e "Checking MongoDB status..."
sudo systemctl status mongod