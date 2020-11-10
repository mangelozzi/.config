#!/bin/bash

# temp="USER INPUT"
read -p "Will install Neovim for the current user, press <ENTER> to continue..."

set -x
NVIM_FILE=nvim.appimage
NVIM_PATH=~/appimages/

mkdir -p $NVIM_PATH
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o $NVIM_PATH$NVIM_FILE
chmod +x $NVIM_PATH$NVIM_FILE
sudo ln -s $NVIM_PATH$NVIM_FILE /usr/bin/nvim

# Get config dir
cd ~
git clone https://github.com/mangelozzi/.config.git ~/.config

# Get my plugins
mkdir -p ~/.config/nvim/tmp/
cd ~/.config/nvim/tmp/
git clone https://github.com/mangelozzi/vim-capesky.git
git clone https://github.com/mangelozzi/nvim-rgflow.lua.git
git clone https://github.com/mangelozzi/vim-wsl.git

echo "alias vim=nvim" >> ~/.bashrc


# Clipboard
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/win32yank.exe

# Install python support
sudo apt install -y python3-pip
pip3 install pynvim

# tsserver language server requires:
sudo apt install -y curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs
echo -e "\n\nTesting Node installation version"
node -v
npm -v
echo -e "\n\n"
sudo npm install -g typescript typescript-language-server jshint prettier-miscellaneous

echo -e "\nInstalling Plugins:"
nvim --headless +PlugInstall +qall

echo -e "\nInstalling Language Server Plugins:"
nvim --headless +"LspInstall html" +"q!"
echo
nvim --headless +"LspInstall cssls" +"q!"
echo
nvim --headless +"LspInstall jsonls" +"q!"
echo
nvim --headless +"LspInstall tsserver" +"q!"
echo
nvim --headless +"LspInstall vimls" +"q!"
echo
nvim --headless +"LspInstall bashls" +"q!"
echo
echo "Get .NET framework"
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O ~/packages-microsoft-prod.deb
sudo dpkg -i ~/packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get install -y aspnetcore-runtime-3.1
nvim --headless +"LspInstall pyls_ms" +"q!"


set +x
echo
echo "Install NVIM Complete."
