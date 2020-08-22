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
sudo npm install -g typescript

echo -e "\nInstalling Plugins:"
nvim --headless +PlugInstall +qall

echo -e "\nInstalling Language Server Plugins:"
nvim --headless +"LspInstall html"
nvim --headless +"LspInstall cssls"
nvim --headless +"LspInstall jsonls"
nvim --headless +"LspInstall tsserver"
nvim --headless +"LspInstall vimls"
nvim --headless +"LspInstall bashls

echo -e "\nCOMPLETE."
