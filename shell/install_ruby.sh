#!/bin/bash
set -e
echo -e "Installing ruby..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements
sleep 3
rvm install 2.4.1
sleep 3
rvm use 2.4.1 --default
sleep 3
gem install bundler -V --no-ri --no-rdoc
sleep 3
echo -e "Checking ruby versions..."
ruby -v
echo -e ""
bundle -v