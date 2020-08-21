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

## AUTHENTICATION

### Linux

#### SSH Keys
- Use SSH keys.
- HTTPS remotes always ask for password, so must change to SSH repo:
WSL doesnt support libsecret, so just use SSH.
  ```
  git remote --verbose
  git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
  ```

Follow GitHub's [Connecting to GitHub with SSH](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) guide:
  1. Check if have `~/.ssh/id_rsa*` keys already, if yes go to step 5.
  2. Open a terminal and run:
          ssh-keygen -t rsa -b 4096 -C "mangelozzi@gmail.com"
  3. Press `<ENTER>` to use the default location.
  4. Enter a the standard michael device password
  5. Start the ssh-agent in the background:
          eval "$(ssh-agent -s)"
  6. Add your SSH private key to the ssh-agent:
          ssh-add ~/.ssh/id_rsa
  7. Copy the SSH key to your clipboard.
          cat ~/.ssh/id_rsa.pub
  8. Go to [`github.com` &rarr; `Settings` &rarr; `SSH and GPG keys` &rarr; `New SSH Key`](https://github.com/settings/keys)
  9. Type in description and paste in key.
  10. Check Github.com fingerprint matches you own key:
          ssh-add -l -E md5

### WSL

Cache for 1 week:
```
    git config --global credential.helper 'cache --timeout=604800'
```

### Windows

WINDOWS: Use manager for the entire machine (system)

    git config --system credential.helper manager

No longer used settings:

    helper = mananger
    helper = store
    Set cache to time out after 1 day 24*60*60=86400
    helper = cache --timeout=86400
