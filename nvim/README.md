# Neovim SETUP

## INSTALLATION
### Linux
```bash
sudo add-apt-repository ppa:Neovim-ppa/stable
sudo apt-get update
sudo apt-get install Neovim
```
Create alias for nvim to be vim (still need to test this)
```
echo "alias vim=nvim" >> ~/.bashrc
```

### Windows
1. Download X64 release from [Neovim releases](https://github.com/Neovim/Neovim/releases)
2. Extract zip to say `C:\utils\Neovim`
    - Should now have `C:\Neovim\bin` and `C:\Neovim\share`
3. Copy `C:\Neovim\bin\nvim-qt.exe` to `vim.exe` for easy starting
4. Double click on it to launch it, right click on the icon and select `Pin to taskbar`
5. Right click on the taskbar link, right click on the name and select properties,
Set the start in location to a common dir, e.g. `C:\code\project`

## CONFIG
### Linux

### Windows
1. Create environment variable used by Neovim to find config:
  - Env variable name: `XDG_CONFIG_HOME`
  - Env variable value: `C:\Users\Michael\.config`
2. Add the bin to the Env variable path:
  - Env variable name: PATH
  - Env variable value to append: `C:\utils\Neovim\bin`

## FONT
Requires a NERD FONT for the NERD TREE icons:\
https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/RobotoMono/Bold/complete
### Linux 
Install font `font\RobotoMono NF.ttf`
### Windows
Install font `font\RobotoMono NF Windows Compatible.ttf`

## CLIP BOARD
### Ubuntu
```
sudo apt install xsel
```
### Windows
Works without it.


## PLUGIN MANAGER
- Neovim, [VimPlug](https://github.com/junegunn/vim-plug)
    1 Already in the config, so no need to install.
    2. Run the command `:PlugInstall` upon first start up

## DEPENDENCIES
Refer to README.md in project root for installation of the following:
- Python via PIP3
- Node via NPM

## PLUGIN DEPENDENCIES
### Neovim Python
```
pip3 install pynvim
```
### Coc-Python
In default installation (so common to all), with:
- NO SUDO!!!!
- May require --user if fails
```
pip3 install black isort mypy flake8 jedi==0.16
```
```
- pynvim             # For python hooks into Neovim
- mypy               # For flake 8 type checking
- flake8             # Coc Syntax linting, (Pylint is very whiny)
- jedi               # Coc Autocomplete
- black              # Coc Autoformatting
- isort              # Coc Sort imports
```

### Neovim Node.js
For Linux prefix with sudo
```
npm install -g Neovim
```

### carlitux/deoplete-ternjs
```
npm install -g tern
```

### coc-eslint
```
npm install -g eslint
```

### Coc
```
:CocInstall coc-python
:CocInstall coc-tsserver coc-eslint 
:CocInstall coc-html coc-css
:CocInstall coc-json coc-svg coc-markdownlint
To Try: :CocInstall coc-snippets coc-pairs coc-prettier
```

## FZF
Automatically installed by VimPlug.

## Ripgrep
### Linux
```
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
```
### Windows
Requires the scoop package manager.
```
scoop install ripgrep
```

### Django
Check filetype with :set filetype?
Will only be set to djangohtml if one of the first 10 lines contains:
```{% extends 
{% block 
{% load 
{# 
```
If linting errors for django syntax could add a {# Comment #} at the beginning of the file.

## HELPFUL
- `:CheckHealth` - Neovim internal checks
- `:CocConfig` - To open CocConfig 
- `CocInfo` - If one gets an error, and Coc informs you to check `ouput channel`, e.g. ESLint output channel

## GIT MERGETOOL
Use Neovim Diff as the default merge tool for git.
Require to set the global config to look like:
```
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

## USEFUL ENVIROMENT VARIABLES
Too see the path of a VIM env variable type, open vim and type:
    :echo $VIM
### $MYVIMRC
  .vimrc equivalent file (init.vim for Neovim)
  <br>e.g. C:\Users\Michael\AppData\Local\nvim\init.vim
### $VIM
  used to locate various user files for Nvim, such as the user startup script
  <br>e.g. C:\Neovim\share\nvim
### $VIMRUNTIME
  The environment variable "$VIMRUNTIME" is used to locate various support
  <br>e.g. C:\Neovim\share\nvim\runtime

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
```
pip install jedi     # For deoplete-jedi - autocomplete
pip install pylint   # For Neomake - syntax linting
```

