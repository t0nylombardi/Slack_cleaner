#!/bin/sh

if [ ! -d "$HOME/.slack_cleaner" ]; then
    echo "Installing YADR for the first time"
    git clone --depth=1 https://github.com/t0nylombardi/Slack_cleaner.git "$HOME/.slack_cleaner"
    cd "$HOME/.slack_cleaner"
    rake install
else
    echo "updating slack_cleaner"
    cd "$HOME/.slack_cleaner"
    git pull
    rake install
fi
