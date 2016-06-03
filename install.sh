#!/bin/sh


echo "Installing slack_cleaner"
git clone --depth=1 https://raw.githubusercontent.com/t0nylombardi/Slack_cleaner/master/install.sh "$HOME/.slack_cleaner"

rake install
