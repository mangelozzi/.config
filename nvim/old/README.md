# NEOVIM CONFIG

## NeoVim Installation
### Ubuntu
```bash
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
```

### Windows
1. Download X64 release from [NeoVim releases](https://github.com/neovim/neovim/releases)
2. Extract zip to say `C:\util\Neovim`
    - Should now have `C:\Neovim\bin` and `C:\Neovim\share`
3. Copy `C:\Neovim\bin\nvim-qt.exe` to `vim.exe` for easy starting
4. .vimrc file setup:
    git clone https://github.com/michael-angelozzi/nvim.git C:\Users\Michael\AppData\Local\nvim
    No longer use: - mklink /J C:\Users\Michael\AppData\Local\nvim E:\Dropbox\Software\neovim\nvim
5. Make Taskbar link with 
    - C:\Neovim\bin\vim.exe -- -S

## Dot Config Files
### Ubuntu
```bash
git clone https://github.com/michael-angelozzi/dot-vim.git ~/.config/nvim
```
### Windows

    
## Font
Requires a NERD FONT for the NERD TREE icons:
https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/RobotoMono/Bold/complete
### Linux 
Install font `font\RobotoMono NF.ttf`
### Linux 
Install font `font\RobotoMono NF Windows Compatible.ttf`

## Plugin Manager
- https://github.com/junegunn/vim-plug

## Plugins Dependencies
Various plugins require pip and npm packages, refer to the top of 

### Git
#### Linux
Require the (global) ~/.gitconfig to look like:
```
[merge]
	tool = nvim

[mergetool]
	keepBackup = false

[mergetool "nvim"]
	cmd = nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'
```
Run the commands:
```
git config --global merge.tool nvim
git config --global mergetool.keepBackup false
git config --global mergetool.nvim.cmd $'nvim -d $LOCAL $REMOTE $MERGED -c \'$wincmd w\' -c \'wincmd J\''
```

### Linux

#### Windows
```git config --global core.preloadindex true
git config --global core.fscache true
git config --global gc.auto 256
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
