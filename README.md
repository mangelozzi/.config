# CONFIG
Runtime configuration files for my home directory.

## Linux
1. Clone repo:
```bash
git clone https://github.com/michael-angelozzi/.config.git ~/.config
```

## Windows
1. Clone repo:
```bash
git clone https://github.com/michael-angelozzi/.config.git C:\Users\Michael\.config
```

## ENV REQUIREMENTS
### Python 
#### Ubuntu
Why not?
```sudo apt install python3.8
```

Building from source [guide](https://linuxize.com/post/how-to-install-python-3-8-on-ubuntu-18-04/):
1. Use check install to controll the installation so it can be uninstalled:
  - `sudo apt-get update && sudo apt-get install checkinstall`
Install requirements to build from source:
1. libffi-dev ...c_types for black
. `sudo apt-get install libffi-dev python3.8-dev`
Not sure about this list: `sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget`
1. Download most recent stable version from [python.org](https://www.python.org/download/other/)
2. Extract archive and cd into the dir
`./configure  --enable-optimizations`
`make`
Use check install so it can be uninstalled if required, call package python3.8
Call make install with `j -4` to use 4 cores.
`sudo checkinstall make install -j 4` (instead of sudo make install)
#### Windows
Download installer from [here](https://www.python.org/downloads/windows/)

## ENV PACKAGE MANAGERS

### PIP
#### Ubuntu
1. `sudo apt -y install python3-pip`
2. `apt-get install python3-venv` (Ubuntu, for venv/ (supposed to be OOTB))
#### Windows
Already bundled in with the windows installer

### Node.js
NPM is bundled with None.js
#### Ubuntu
```
sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
npm -v
```
#### Windows
Download and run installer from [node homepage](https://nodejs.org/en/)

## Scoop
A Windows Package manager
1. Press `WIN+R` -> `Powershell`
2. Run `iwr -useb get.scoop.sh | iex`

## Ripgrep
For searching within files
### Ubuntu
```
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
```
### Windows
```
scoop install ripgrep
```
PS ignore the `Couldn't find manifest for 'vscredist' from 'extras' bucket`

## Fd
For searching file names
### Ubuntu
```
sudo apt install fd-find
```
Unfortunately the name `fd` is already taken, so add to bashrc: `alias fd=fdfind` 

### Windows
```
scoop install fd
```