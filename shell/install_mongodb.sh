#!/bin/bash
set -e
echo -e "Installing MongoDB..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
apt-get update -qq && apt-get install -y mongodb-org
echo -e "Starting MongoDB..."
systemctl start mongod
systemctl enable mongod
sleep 3
echo -e "Checking MongoDB status..."
systemctl status mongod