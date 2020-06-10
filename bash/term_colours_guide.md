[Adapated from stackoverflow guide here](https://askubuntu.com/a/1042242/433891)
You can change the highlight color of the terminal by using an environment variable, `LS_COLORS`, which you can set like this:

<!-- language: bash -->

    export LS_COLORS='ms=01;31'

---

# Numeric options

The numbers can style text, change the foreground color or the background color, or change fonts.

The starting conditions for all `GREP_COLORS` options are the terminal's default text style, font, and colors. Resetting any of these will revert to the terminal's defaults, not any of `grep`'s defaults.

### Legend

* <code>*ᴀ*<b>;</b>*ʙ*<b>;</b>*…*</code> — <code>**;**</code> separates numeric options that you want to combine (e.g., bold yellow-on-black text combines options `1`, `33`, and `40` into `1;33;40`)
* <code>**+**<i>ᴇꜰꜰᴇᴄᴛ</i></code> — *ᴇꜰꜰᴇᴄᴛ* gets turned on when you use that numeric option
* <code>**-**<i>ᴇꜰꜰᴇᴄᴛ</i></code> — *ᴇꜰꜰᴇᴄᴛ* gets turned off when you use that numeric option
* <code>**color**</code>, <code>**green**</code>, <code>**cyan**</code>, and <code>**grey**</code> — in the "Text styling" section, these refer to the foreground color
* <code>**colors**</code> — in the "Text styling" section, this refers to both the foreground color and the background color
* <code>**this color**</code> — in the "Foreground colors" section, this refers to the foreground color; in the "Background colors" section, this refers to the background color

### Text styling

An empty string or `0` resets all text styling and resets both colors to the defaults but **does not** reset the font to the default.

<!-- language: lang-none -->

    ┏━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━┓
    ┃ ### ┃ GNOME Terminal          ┃ xterm                   ┃ non-GUI TTY           ┃
    ┡━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━┩
    │     │ «reset style+colors»    │ «reset style+colors»    │ «reset style+colors»  │
    │   0 │ «reset style+colors»    │ «reset style+colors»    │ «reset style+colors»  │
    ├─────┼─────────────────────────┼─────────────────────────┼───────────────────────┤
    │   1 │ +bold, +brighter color  │ +bold, +brighter color  │ +brighter color,      │
    │     │                         │                         │   -forced grey        │
    │   2 │ +fainter color          │ +fainter color          │ +forced grey          │
    │   3 │ +italic                 │ +italic                 │ +forced green         │
    │     │                         │                         │   ● overrides 2 and 4 │
    │   4 │ +underline              │ +underline              │ +forced cyan          │
    │     │                         │                         │   ● overrides 2       │
    │   5 │ «no effect»             │ +blink                  │ «no effect»           │
    │   7 │ +invert colors          │ +invert colors          │ +invert colors        │
    │   8 │ +invisible              │ +invisible              │ «no effect»           │
    │     │                         │   ● underline appears   │                       │
    │   9 │ +strikethrough          │ +strikethrough          │ «no effect»           │
    ├─────┼─────────────────────────┤                         ├───────────────────────┤
    │  21 │ -bold, -brighter color, │ +double underline       │ -brighter color,      │
    │     │   -fainter color        ├─────────────────────────┤   -forced grey        │
    │  22 │ -bold, -brighter color, │ -bold, -brighter color, │ -brighter color,      │
    │     │   -fainter color        │   -fainter color        │   -forced grey        │
    │  23 │ -italic                 │ -italic                 │ -forced green         │
    │  24 │ -underline              │ -underline,             │ -forced cyan          │
    │     │                         │   -double underline     │                       │
    │  25 │ «no effect»             │ -blink                  │ «no effect»           │
    │  27 │ -invert colors          │ -invert colors          │ -invert colors        │
    │  28 │ -invisible              │ -invisible              │ «no effect»           │
    │  29 │ -strikethrough          │ -strikethrough          │ «no effect»           │
    └─────┴─────────────────────────┴─────────────────────────┴───────────────────────┘

### Foreground colors

<!-- language: lang-none -->

    ┏━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━┓
    ┃ ### ┃ GNOME Terminal          ┃ xterm                   ┃ non-GUI TTY           ┃
    ┡━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━┩
    │  39 │ «reset this color»      │ «reset this color»      │ «reset this color»    │
    ├─────┼─────────────────────────┼─────────────────────────┼───────────────────────┤
    │  30 │ very dark grey          │ black                   │ black                 │
    │  31 │ dull red                │ red                     │ light red             │
    │  32 │ dull green              │ light green             │ light green           │
    │  33 │ dull yellow             │ yellow                  │ yellow                │
    │  34 │ greyish blue            │ dark blue               │ sky blue              │
    │  35 │ dull purple             │ purple                  │ purple                │
    │  36 │ teal                    │ cyan                    │ cyan                  │
    │  37 │ light grey              │ light grey              │ light grey            │
    ├─────┼─────────────────────────┼─────────────────────────┼───────────────────────┤
    │  90 │ dark grey               │ dull grey               │ dull grey             │
    │  91 │ red                     │ bright red              │ bright red            │
    │  92 │ lime green              │ bright green            │ bright green          │
    │  93 │ yellow                  │ bright yellow           │ pure yellow           │
    │  94 │ light greyish blue      │ dull blue               │ deep blue             │
    │  95 │ light purple            │ magenta                 │ magenta               │
    │  96 │ cyan                    │ bright cyan             │ bright cyan           │
    │  97 │ off white               │ white                   │ white                 │
    ├─────┴──────┬──────────────────┴─────────────────────────┴───────────────────────┤
    │ 38;2;ʀ;ɢ;ʙ │ replace ʀ, ɢ, and ʙ with RGB values from 0 to 255                  │
    │            │   for closest supported color (non-GUI TTY has only 16 colors!)    │
    │ 38;5;ɴ     │ replace ɴ with value from 256-color chart below                    │
    │            │   for closest supported color (non-GUI TTY has only 16 colors!)    │
    └────────────┴────────────────────────────────────────────────────────────────────┘

### Background colors

Note that the non-GUI TTY doesn't provide a brighter background color series.

<!-- language: lang-none -->

    ┏━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━┓
    ┃ ### ┃ GNOME Terminal          ┃ xterm                   ┃ non-GUI TTY           ┃
    ┡━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━┩
    │  49 │ «reset this color»      │ «reset this color»      │ «reset this color»    │
    ├─────┼─────────────────────────┼─────────────────────────┼───────────────────────┤
    │  40 │ very dark grey          │ black                   │ black                 │
    │  41 │ dull red                │ red                     │ light red             │
    │  42 │ dull green              │ light green             │ light green           │
    │  43 │ dull yellow             │ yellow                  │ yellow                │
    │  44 │ greyish blue            │ dark blue               │ sky blue              │
    │  45 │ dull purple             │ purple                  │ purple                │
    │  46 │ teal                    │ cyan                    │ cyan                  │
    │  47 │ light grey              │ light grey              │ light grey            │
    ├─────┼─────────────────────────┼─────────────────────────┼╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶╴╶┤
    │ 100 │ dark grey               │ dull grey               │ black                 │
    │ 101 │ red                     │ bright red              │ light red             │
    │ 102 │ lime green              │ bright green            │ light green           │
    │ 103 │ yellow                  │ bright yellow           │ yellow                │
    │ 104 │ light greyish blue      │ dull blue               │ sky blue              │
    │ 105 │ light purple            │ magenta                 │ purple                │
    │ 106 │ cyan                    │ bright cyan             │ cyan                  │
    │ 107 │ off white               │ white                   │ light grey            │
    ├─────┴──────┬──────────────────┴─────────────────────────┴───────────────────────┤
    │ 48;2;ʀ;ɢ;ʙ │ replace ʀ, ɢ, and ʙ with RGB values from 0 to 255                  │
    │            │   for closest supported color (non-GUI TTY has only 8 colors!)     │
    │ 48;5;ɴ     │ replace ɴ with value from 256-color chart below                    │
    │            │   for closest supported color (non-GUI TTY has only 8 colors!)     │
    └────────────┴────────────────────────────────────────────────────────────────────┘

### 256-color chart

>[![256-color chart][1]][1]

><sup><sup>Above chart is a screenshot of content published in ["ANSI escape code, 8-bit colors" on Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit), authored [by CMG Lee et al. on 24 February 2016 and later](https://en.wikipedia.org/w/index.php?title=ANSI_escape_code&diff=706645748&oldid=706104066), and [licensed by the authors](https://wikimediafoundation.org/wiki/Terms_of_Use/en#7._Licensing_of_Content) under both [the CC BY-SA 3.0 copyright license](https://creativecommons.org/licenses/by-sa/3.0/) and [the GFDL copyright license](https://www.gnu.org/copyleft/fdl.html).</sup></sup></blockquote>

Colors from the 256-color chart above can be used as follows:

* `38;5;ɴ` — replace ɴ with the value of a particular color in the chart above to change the **foreground color** to the closest color the terminal supports
* `48;5;ɴ` — replace ɴ with the value of a particular color in the chart above to change the **background color** to the closest color the terminal supports

For example, `38;5;214;48;5;30` will set the foreground to color `214` and the background to color `30`, giving an orange-on-teal result on terminals that support it.

Note that not all terminals support all 256 colors, so it's important to realize that the chosen color might not be used. Only the supported color closest to the one chosen will be used.

For example, the non-GUI TTY only supports the basic 16 colors for foreground and the basic 8 colors for background, so the closest colors that end up being used may not be what you expect. As an example, the orange-on-teal selection above (`38;5;214;48;5;30`) shows as yellow-on-black in the non-GUI TTY, since those are the closest supported colors.

### Fonts

`10` is the default font. `11` through `20` are potential alternate fonts  (`20` usually means [a 𝕱𝖗𝖆𝖐𝖙𝖚𝖗 font](https://en.wikipedia.org/wiki/Fraktur) in the rare terminals that support it). Only `10` and `12` seem to exist by default in the non-GUI TTY, and none exist in GNOME Terminal or `xterm`.

`grep` doesn't properly switch fonts back before exiting, so run `reset` if you get stuck in an unwanted font after `grep` returns to the shell.

<!-- language: lang-none -->

    ┏━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━┓
    ┃ ### ┃ GNOME Terminal          ┃ xterm                   ┃ non-GUI TTY           ┃
    ┡━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━┩
    │  10 │ «no effect»             │ «no effect»             │ «reset font»          │
    │  11 │ «no effect»             │ «no effect»             │ -messed up font       │
    │  12 │ «no effect»             │ «no effect»             │ +messed up font       │
    └─────┴─────────────────────────┴─────────────────────────┴───────────────────────┘

><sup>"Numeric options" section sources:</sup>  
> &nbsp; &nbsp; &nbsp; &nbsp; <sup>● ["ANSI escape code, SGR (Select Graphic Rendition) parameters" on Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters)</sup>  
> &nbsp; &nbsp; &nbsp; &nbsp; <sup>● Experimental verification on GNOME Terminal, `xterm`, and non-GUI-mode TTY on Ubuntu 16.04</sup>  

---

[![examples of color changes after setting `GREP_COLORS`][2]][2]

The default value of `GREP_COLORS` is `'ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'`

The meaning of every element accepted on `GREP_COLORS` can be checked at [GNU.org's manual page](https://www.gnu.org/software/grep/manual/grep.html#index-GREP_005fCOLORS-environment-variable).

For completion, and as pointed out by @damadam, you need to add the `export` to your `.bashrc` in order to save the changes.

**Related:**

[Multicolored Grep](https://unix.stackexchange.com/questions/104350/multicolored-grep)

[Use different colors for every another grep](https://superuser.com/questions/676228/use-different-colors-for-every-another-grep)

  [1]: https://i.stack.imgur.com/UMlV0.png
  [2]: https://i.stack.imgur.com/th3Ih.png
