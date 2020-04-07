# Emacs Config

;; Core packages
;; use-package, Evil, Helm, magit

;; Maybes:
;; https://github.com/bbatsov/projectile
;; https://github.com/emacs-evil/evil-surround

## Installation
### Linux
Don't just apt-get install emacs, will install old version with out date package keys.
Recommend installing at least version emacs26.3:
1. `sudo add-apt-repository ppa:kelleyk/emacs`
2. `sudo apt update`
3. `sudo apt install emacs`

### Windows
1. Run installer
2. Add emacs bin dir (e.g. `C:\utils\emacs\bin`) to Windows `Path` environment variable.

## Config from github
### Linux
1. `git clone https://github.com/michael-angelozzi/dot-emacs.git ~/.emacs.d`
### Windows
1. Create an environment variable called `HOME` set to value of `C:\Users\Michael`
2. `git clone https://github.com/michael-angelozzi/dot-emacs.git C:\Users\Michael\.emacs.d`
3. Change CRLF to CR for `michael-theme.el` or else will generate an error that does not have a package version.


## Env Requirements
### Python 
#### Ubuntu:
Building from source [guide](https://linuxize.com/post/how-to-install-python-3-8-on-ubuntu-18-04/):
1. Use check install to controll the installation so it can be uninstalled:
  - `sudo apt-get update && sudo apt-get install checkinstall`
Install requirements to build from source:
1. libffi-dev ...c_types for black
. `sudo apt-get install libffi-dev python3.8-dev`
Not sure about this list: `sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget`
`sudo apt update`
1. Download most recent stable version from [python.org](ttps://www.python.org/download/other/)
2. Extract archive and cd into the dir
`./configure  --enable-optimizations`
`make`
Use check install so it can be uninstalled if required, call package python3.8
Call make install with `j -4` to use 4 cores.
`sudo checkinstall make install -j 4` (instead of sudo make install)

### project prep
Install python
Make Venv
install 2 x requirements files
For postgres pip installation:
Might be cause had not installed postgresql yet: `sudo apt-get install libpq-dev`

### PIP
1. `sudo apt -y install python3-pip`
2. `apt-get install python3-venv` (Ubuntu, for venv/ (supposed to be OOTB))
### Node.js
Download from [node homepage](https://nodejs.org/en/)
```
sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
npm -v
```

## Eglot (Language Server for Emacs)
The lanuage servers must be accessible on the path. e.g. for pyls, if you type pyls and its not found that is a problem.
To find the binary: `sudo find / -name pyls`
Then add it to: `sudo vim /etc/environment`
Apply the changes `source /etc/environment` (or reboot)
Check $PATH has been updated: `echo $PATH`

### Python Language Server
[oython-language-server on Github](https://github.com/palantir/python-language-server)
#### Requirements
1. If `jedi` is already installed, uninstall it because pyls (python-language-server) require a certain version of jedi, so let it install it automaticall 
2. `pip3 uninstall jedi`
3. `pip3 install rope mccabe pyflakes`
#### Installation
pyls install python-language-server (must install it before python-language-server)
1. `pip3 install pyls-black`
2. `pip3 install python-language-server`

pip3 install jedi rope mccabe pyflakes pyls-black

pip3 install jedi rope mccabe pyflakes pyls-black



### Eglot Requirements 

#### Eglot - CSS/SCSS
sudo npm install --global vscode-css-languageserver-bin
Test it is on path with bash command: `css-languageserver --stdio`

#### Eglot - JavsScript

## Bin
npm install tern

### Flycheck
Run (for flycheck) so that it can be :
`package-refresh-contents`

1. `sudo apt -y install python3-pip`
2. `python3.X -m pip install flake8`

