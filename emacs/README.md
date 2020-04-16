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

Lastest unstable version
```
sudo add-apt-repository ppa:ubuntu-elisp/ppa
sudo apt-get update
sudo apt install emacs-snapshot
```

### Windows
1. Run installer for the version WITHOUT -no-deps (no dependencies), e.g. `emacs-27.0.90-2-x86_64.zip`
2. Add emacs bin dir (e.g. `C:\utils\emacs\bin`) to Windows `Path` environment variable.

## Config from github
### Linux
1. `git clone https://github.com/michael-angelozzi/dot-emacs.git ~/.emacs.d`
### Windows
1. Create an environment variable called `HOME` set to value of `C:\Users\Michael`
2. `git clone https://github.com/michael-angelozzi/dot-emacs.git C:\Users\Michael\.emacs.d`
3. Change CRLF to CR for `michael-theme.el` or else will generate an error that does not have a package version.


## Env Requirements

### project prep
Install python
Make Venv
install 2 x requirements files
For postgres pip installation:
Might be cause had not installed postgresql yet: `sudo apt-get install libpq-dev`

## PLUGIN MANAGERS
- Emacs, built in package manager and `use-package` macro

## DEPENDENCIES
Refer to README.md in project root for installation of the following:
- Python with PIP3
- Node with NPM

## PLUGIN DEPENDENCIES

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

