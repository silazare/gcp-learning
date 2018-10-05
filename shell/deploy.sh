#!/bin/bash
set -e
echo -e "Installing application..."
git clone https://github.com/silazare/reddit.git ~/reddit
cd ~/reddit && bundle install
puma -d
echo -e "Checking puma is running..."
ps aux | grep [p]uma
