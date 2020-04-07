# GIT GLOBAL SETUP


## INSTALLATION
### Linux
Follow [installation instructions](https://git-scm.com/download/linux).
### Windows
Download from [official site](https://git-scm.com/download/win).

## CONFIGURATION
### Linux
### Windows
1. Create environment variable used by Neovim to find config:
  - Env variable name: `XDG_CONFIG_HOME`
  - Env variable value: `C:\Users\Michael\.config`

## GIT CONFIG FILE
The config file is already setup (and checked out to `.config/git/config`).
These commands here are just provided for a reference:
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
