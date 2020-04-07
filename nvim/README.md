# NEOVIM SETUP

## INSTALLATION
### Linux
```bash
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
```

### Windows
1. Download X64 release from [NeoVim releases](https://github.com/neovim/neovim/releases)
2. Extract zip to say `C:\util\Neovim`
    - Should now have `C:\Neovim\bin` and `C:\Neovim\share`
3. Copy `C:\Neovim\bin\nvim-qt.exe` to `nvim.exe` for easy starting
4. Make Taskbar link with: `C:\util\Neovim\bin\nvim.exe -- -S`

## CONFIG
### Linux
1. Clone repo:
```bash
git clone https://github.com/michael-angelozzi/dot-vim.git ~/.config/nvim
```

### Windows
1. Clone repo:
```bash
git clone https://github.com/michael-angelozzi/dot-vim.git C:\Users\Michael\.config\nvim
```
2. Create environment variable used by Neovim to find config:
    - Env variable name: `XDG_CONFIG_HOME`
    - Env variable value: `C:\Users\Michael\.config`


## FONT
Requires a NERD FONT for the NERD TREE icons:\
https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/RobotoMono/Bold/complete
### Linux 
Install font `font\RobotoMono NF.ttf`
### Windows
Install font `font\RobotoMono NF Windows Compatible.ttf`

## PLUGIN MANAGER
Follow installation instructions from their github base:
- https://github.com/junegunn/vim-plug#installation

## DEPENDENCIES

### Git
Require to set the (global) `~/.gitconfig` to look like:
```
[merge]
    tool = nvim

[mergetool]
    keepBackup = false

[mergetool "nvim"]
    cmd = nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'
```

#### Linux
```bash
git config --global merge.tool nvim
git config --global mergetool.keepBackup false
git config --global mergetool.nvim.cmd $'nvim -d $LOCAL $REMOTE $MERGED -c \'$wincmd w\' -c \'wincmd J\''
```

#### Windows
```bash
git config --global user.name "Michael Angelozzi"
git config --global user.email mangelozzi@gmail.com
git config --global core.preloadindex true
git config --global core.fscache true
git config --global gc.auto 256

git config --global merge.tool nvim
git config --global mergetool.keepBackup false
git config --global mergetool.nvim.cmd $'nvim -d $LOCAL $REMOTE $MERGED -c \'$wincmd w\' -c \'wincmd J\''
```

### PIP Python packages (in VENV!):
    pip install pynvim (For python hooks into neovim)
    pip install flake8 (Syntax linting for Coc)
    deprecated: pip install jedi   (For deoplete-jedi - autocomplete)
    deprecated: pip install pylint (For Neomake - syntax linting)

### NPM Node.js packages:
    npm install -g neovim
    npm install -g tern     for: carlitux/deoplete-ternjs

## Userful Enviroment Variables
Too see the path of a VIM env variable type, open vim and type:
    :echo $VIM
### $MYVIMRC
  .vimrc equivalent file (init.vim for neovim)
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
2. In NeoVim -> In the menu goto Terminal -> Settings -> Colors tab, and change blue and purple
    alias vim="nvim"
