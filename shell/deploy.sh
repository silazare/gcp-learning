#!/bin/bash
set -e

source ~/.profile
git clone https://github.com/silazare/reddit.git
cd reddit
sed -i 's/127.0.0.1:27017/10.132.0.2:27017/g' app.rb
bundle install

sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma && sudo systemctl enable puma
