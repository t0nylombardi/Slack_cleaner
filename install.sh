#!/bin/sh


echo "Installing slack_cleaner"
git clone --depth=1 https://github.com/skwp/dotfiles.git "$HOME/.slack_cleaner"

rake install
