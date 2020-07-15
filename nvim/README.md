# Neovim SETUP

## INSTALLATION

### Ubuntu (Stable) Installation

```bash
sudo add-apt-repository ppa:Neovim-ppa/stable
sudo apt-get update
sudo apt-get install Neovim
```

Create alias for nvim to be vim (still need to test this)

```bash
echo "alias vim=nvim" >> ~/.bashrc
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

### Windows Installation

1. Install via scoop (recommended), choose one of the following:

```bat
scoop install neovim
scoop install neovim-nightly
```

or

1. Download X64 release from [Neovim releases](https://github.com/Neovim/Neovim/releases)
2. Extract zip to say `C:\utils\Neovim`
    - Should now have `C:\Neovim\bin` and `C:\Neovim\share`
3. Copy `C:\Neovim\bin\nvim-qt.exe` to `vim.exe` for easy starting
4. Double click on it to launch it, right click on the icon and select `Pin to taskbar`
5. Right click on the task bar link, right click on the name and select properties,
Set the start in location to a common dir, e.g. `C:\code\project`


#### <span style="color: red;">WARNING!!! If `neovim-qt.exe` takes 30 seconds to close</span>

A recent Windows update seems to of changed things.  
**DO NOT** pin to the task bar:  
`C:\Users\Michael\scoop\apps\neovim-nightly\current\bin\nvim-qt.exe`

Use the none current version, e.g.:  
`C:\Users\Michael\scoop\apps\neovim-nightly\nightly-20200618\bin\nvim-qt.exe`

## CONFIG

### Ubuntu Config

- N/A

### Windows Config

1. Create environment variable used by Neovim to find config:
  - Env variable name: `XDG_CONFIG_HOME`
  - Env variable value: `C:\Users\Michael\.config`
2. Add the bin to the Env variable path:
  - Env variable name: PATH
  - Env variable value to append:
    - `C:\Users\Michael\scoop\apps\neovim-nightly\current\bin` or
    - `C:\utils\Neovim\bin`

## FONT

Requires a NERD FONT for the (NERD TREE icons)[https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/RobotoMono/Bold/complete]  
Just needs to be installed, not set as the Neovim font for NERDTree to using
the file browser icons.

### Ubuntu Font

Install font `font\RobotoMono NF.ttf`

### Windows Font

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

### Windows Clipboard

Works without it.

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

### Coc-Python

In default installation (so common to all), with:

- NO SUDO!!!!
- May require --user if fails

```shell
pip3 install black isort mypy flake8 jedi==0.16
```

```none
- pynvim             # For python hooks into Neovim
- mypy               # For flake 8 type checking
- flake8             # Coc Syntax linting, (Pylint is very whiny)
- jedi               # Coc Autocomplete
- black              # Coc Autoformatting
- isort              # Coc Sort imports
```

### Neovim Node.js

For Linux prefix with sudo

```shell
npm install -g Neovim
```

### carlitux/deoplete-ternjs

```shell
npm install -g tern
```

### coc-eslint

```shell
npm install -g eslint
```

### Coc

```viml
:CocInstall coc-python
:CocInstall coc-tsserver coc-eslint
:CocInstall coc-html coc-css
:CocInstall coc-json coc-svg coc-markdownlint
To Try: :CocInstall coc-snippets coc-pairs coc-prettier
```

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
- `:CocConfig` - To open CocConfig 
- `CocInfo` - If one gets an error, and Coc informs you to check
   `ouput channel`, e.g. ESLint output channel

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


### deoplete-jedi

```shell
pip install jedi     # For deoplete-jedi - autocomplete
pip install pylint   # For Neomake - syntax linting
```

