#!/bin/bash

# Echo commands
set -x

sudo apt update

# Ripgrep
# if ! command -v rg &> /dev/null
# then
#     curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
#     sudo dpkg -i ripgrep_11.0.2_amd64.deb
# fi
sudo apt install ripgrep

# fd
# bash_ext will create an alias for fd=fd-find
sudo apt install fd-find

# FZF
# The Ubuntu 20.04 repo is out of date, require at least 0.22.0
# sudo apt install fzf
if ! command -v fzf &> /dev/null
then
    read -p "FZF will be installed only for the current user, press <ENTER> to continue..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

# Tree
sudo apt install tree

# Unzip
sudo apt install unzip

set +x
echo
echo "Install UTILS complete."
