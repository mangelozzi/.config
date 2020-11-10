# Neovim SETUP

## INSTALLATION

### Installation Script

- Just run [this script](../install/3_nvim.sh)
- Note: _Follow the terminal setup for the font._

### Ubuntu (Stable) Installation

```bash
sudo add-apt-repository ppa:Neovim-ppa/stable
sudo apt-get update
sudo apt-get install Neovim
```

### Ubuntu (Nightly) Installation

To use appimage stable, just replace `nightly` &rarr; `stable`

```bash
NVIM_FILE=nvim.appimage;NVIM_PATH=~/appimages/;
mkdir -p NVIM_PATH
sudo curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o $NVIM_PATH$NVIM_FILE
sudo chmod +x $NVIM_PATH$NVIM_FILE
sudo ln -s $NVIM_PATH$NVIM_FILE /usr/bin/nvim
```

### Alias
Create alias for nvim to be vim

```bash
echo "alias vim=nvim" >> ~/.bashrc
```

## FONT

Requires a NERD FONT for the (NERD TREE icons)[https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/RobotoMono/Bold/complete]  

### Ubuntu Font

Install font `font\RobotoMono NF.ttf`

### Windows Font

Use windows terminal, which is set to use this font:
```bat
sudo scoop install inconsolatago-nf
```

RobotMono doesnt work well with windows terminal:
```shell
sudo scoop install RobotoMono-NF
```
or
Install font `font\RobotoMono NF Windows Compatible.ttf`

## CLIPBOARD

### Ubuntu Clipboard

```bash
sudo apt install xsel
```

### Ubuntu WSL2 Ubuntu Clipboard

```bash
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
mv /tmp/win32yank.exe /usr/local/bin/win32yank.exe
```

## PLUGIN MANAGER

Use [VimPlug](https://github.com/junegunn/vim-plug)

1. Already in the config, so no need to install.
2. Install my own plugins `vim-wsl` and `nvim-rgflow.lua` to `tmp/`
3. Run the command `:PlugInstall` upon first start up

## DEPENDENCIES

Refer to [Software setup docs](https://github.com/michael-angelozzi/software_setup) for installation of the following:

- Python via PIP3
- Node via NPM
- ripgrep
- fzf
- If using the nightly, may need to Install LuaJIT 2.1.0beta3 manually (to get colorizer to work):
  1. First install checkinstall
  2. Then download it `curl https://luajit.org/download/LuaJIT-2.1.0-beta3.tar.gz -o luajit210beta3`
  3. `tar -xf luajit210beta3.tar.gz`
  4. `cd ...`
  5. `make`
  6. `sudo checkinstall`

## PLUGIN DEPENDENCIES

### Neovim Python

```shell
pip3 install pynvim
```

### Neovim-LSP

In default installation (so common to all), with:

- NO SUDO!!!!
- May require --user if fails

#### Install pyls_ms

More widely used, and performs better than the palantir (questionable company) pyls.

This script from https://github.com/neovim/nvim-lsp#pyls_ms did not work for me
```
curl -L https://dot.net/v1/dotnet-install.sh -o ~/dotnet-install.sh
bash ~/dotnet-install.sh
```

Microsoft official dos:
<https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#2004->
Only need the runtime, not the SDK or ASP.net stuff.
```bash
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get install -y aspnetcore-runtime-3.1
```

### Neovim Node.js

For Linux prefix with sudo

`tsserver` language server requires:
```shell
sudo npm install -g typescript
```

### Neovim-LSP

Can't install `pyls` via Neovim (yet). Must install via `pip`.  
Within vim run:

```viml
:LspInstall html
:LspInstall cssls
:LspInstall jsonls
:LspInstall tsserver
:LspInstall vimls
:LspInstall bashls
```

Check out `sumneko_lua`

#### FZF

Install via 'scoop'. Can also be automatically installed by VimPlug.

#### Windows FZF

Add it to user `%Path%`: `C:\Users\Michael\.config\nvim\tmp\fzf\bin`

### Django

Check filetype with :set filetype?
Will only be set to djangohtml if one of the first 10 lines contains:

```html
{% extends
{% block
{% load
{#
```

If  linting errors for django syntax could add a `{# Comment #}` at the beginning
of the file.

## HELPFUL

- `:CheckHealth` - Neovim internal checks

### LUA

Can get LUA for windows (for independent dev) here (its already built into Neovim):
- https://sourceforge.net/projects/luabinaries/

## GIT MERGETOOL
Use Neovim Diff as the default merge tool for git.
Require to set the global config to look like:

```ini
[merge]
    tool = nvim
[mergetool]
    keepBackup = false
[mergetool "nvim"]
    cmd = nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'
```

Run the commands (already setup in .config/git/config):

```bash
git config --global merge.tool nvim
git config --global mergetool.keepBackup false
git config --global mergetool.nvim.cmd $'nvim -d $LOCAL $REMOTE $MERGED -c \'$wincmd w\' -c \'wincmd J\''
```

## USEFUL ENVIRONMENT VARIABLES

Too see the path of a VIM env variable type, open VIM and type:
   - `:echo $VIM`

### $MYVIMRC

.vimrc equivalent file (init.vim for Neovim)  
e.g. C:\Users\Michael\AppData\Local\nvim\init.vim

### $VIM

used to locate various user files for Nvim, such as the user startup script  
e.g. C:\Neovim\share\nvim

### $VIMRUNTIME

The environment variable "$VIMRUNTIME" is used to locate various support  
e.g. C:\Neovim\share\nvim\runtime

See runtimepath --> :set runtimepath?

## DEPRICATED: 

Get ctags and make sure the ctags.exe accessible by PATH.
    - Downloaded universal tags (ctags successor) from:
      https://github.com/universal-ctags/ctags-win32/releases
    - Already had GCC installed with Cygwin, so dropped ctags.exe into C:\cygwin64\bin

### Linux Installation

2. In Neovim -> In the menu goto Terminal -> Settings -> Colors tab, and change blue and purple
    alias vim="nvim"

5. Right click on the taskbar link, right click on the name and select properties,
then select append the `Target` with `-- -S` to restore any session files. Will get an error on first launch since no session is made, can create one with `mks`.

Within CocConfig:
"eslint.options": {"configFile": "C:/Users/Michael/.config/nvim/coc-eslint.json"},

### CoC Helpful Commands

- `:CocConfig` - To open CocConfig 
- `CocInfo` - If one gets an error, and Coc informs you to check
   `ouput channel`, e.g. ESLint output channel

### deoplete-jedi

```shell
pip install jedi     # For deoplete-jedi - autocomplete
pip install pylint   # For Neomake - syntax linting
```

#### Install Pyls (slower than pyls_ms)

Install python-language-server first, and it will install the right version
of dependencies it requires.
```shell
pip3 install pynvim python-language-server
```

Check that `pyls` is on the path with `which pyls`. If it prints nothing, search
for it with: `find / -name pyls`. It's likely to of been installed in:
```
/home/michael/.local/lib/python3.8/site-packages/pyls
/home/michael/.local/bin/pyls
```
Normally `~/.profile` adds `/home/michael/.local/bin` to the `$PATH`.
If its not in your path, log into WSL with `bash.exe ~ -l` (can drop the `.exe` part) or `wsl ~ bash -l`
Log out the shell and back in. `which pyls` should print the executable and
Neovim `:checkhealth` should show pyls is OK.

#### Install Pyls Plugins

```shell
pip3 install rope pyls-mypy pyls-isort pyls-black
```

```none
- pynvim            # For python hooks into Neovim
- rope              # For Completions and renaming
- mypy              # For flake 8 type checking
- pyls-mypy         # Add mypy type checking to lsp (Install mypy)
- isort             # Sort imports
- pyls-isort        # Add isort import sorting to lsp
- black             # You can have it any colour
- pyls-black        # Add black code formating to lsp, not compatible with yapf or autopep8
- pyflakes          # Python linter
- python-language-server # Will install the right verison of Jedi
```
