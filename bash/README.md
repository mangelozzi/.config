# BASH

## Customise BASH Run time commands

1. Open `~/.bashrc`
2. Add to the end of the file: `source ~/.config/bash/bashrc_ext`

## SSH CONFIG

Copy `ssh/config` file from Cryptomator over `~/.ssh/config`. By default the
one in .config is just a skelton file.

## ORDER OF FILES BEING SOURCED

For BASH: Read down the appropriate column. Executes `A`, then `B`, then `C`, etc.
The `B1`, `B2`, `B3` means it executes only the first of those files found.  `(A)`
or `(B2)` means it is normally sourced by (read by and included in) the
primary file, in this case A or `B2`.

```none
+---------------------------------+-------+-----+------------+
|                                 | Interactive | non-Inter. |
+---------------------------------+-------+-----+------------+
|                                 | login |    non-login     |
+---------------------------------+-------+-----+------------+
|                                 |       |     |            |
|   ALL USERS:                    |       |     |            |
+---------------------------------+-------+-----+------------+
|BASH_ENV                         |       |     |     A      | not interactive or login
|                                 |       |     |            |
+---------------------------------+-------+-----+------------+
|/etc/profile                     |   A   |     |            | set PATH & PS1, & call following:
+---------------------------------+-------+-----+------------+
|/etc/bash.bashrc                 |  (A)  |  A  |            | Better PS1 + command-not-found
+---------------------------------+-------+-----+------------+
|/etc/profile.d/bash_completion.sh|  (A)  |     |            |
+---------------------------------+-------+-----+------------+
|/etc/profile.d/vte-2.91.sh       |  (A)  |     |            | Virt. Terminal Emulator
|/etc/profile.d/vte.sh            |  (A)  |     |            |
+---------------------------------+-------+-----+------------+
|                                 |       |     |            |
|   A SPECIFIC USER:              |       |     |            |
+---------------------------------+-------+-----+------------+
|~/.bash_profile    (bash only)   |   B1  |     |            | (doesn't currently exist)
+---------------------------------+-------+-----+------------+
|~/.bash_login      (bash only)   |   B2  |     |            | (didn't exist) **
+---------------------------------+-------+-----+------------+
|~/.profile         (all shells)  |   B3  |     |            | (doesn't currently exist)
+---------------------------------+-------+-----+------------+
|~/.bashrc          (bash only)   |  (B2) |  B  |            | colorizes bash: su=red, other_users=green
+---------------------------------+-------+-----+------------+
|                                 |       |     |            |
+---------------------------------+-------+-----+------------+
|~/.bash_logout                   |    C  |     |            |
+---------------------------------+-------+-----+------------+
```

`**` (sources !/.bashrc to colorize login, for when booting into non-gui)

TIP: SEE TABLE in `/etc/profile` of BASH SETUP FILES AND THEIR LOAD SEQUENCE

