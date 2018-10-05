#!/bin/bash
set -e
cd /home/appuser
git clone https://github.com/silazare/reddit.git
cd reddit
bundle install
puma -d
