#!/bin/python
"""A class for colorizing the terminal colors
Refer to : https://misc.flogisoft.com/bash/tip_colors_and_formatting

The commands gnerally return the required color code to print, however if the
optionaly argument echo is set to True, then it also prints the color escape
code.

Example Usage - With echo=False (default way returns the code to be printed):
    import Colorize
    print(f"{Colorize.fg('red')}{Colorize.bg('white')}Warning!")
    print(f"{Colorize.fg_255(77)}{Colorize.bg_255(253)}That was bad")
    print(Colorize.reset(), end="")

Example Usage - With echo=True to print the escape codes:
    import Colorize
    Colorize.fg("red", echo=True)
    Colorize.bg("white", echo=True)
    print("Warning!")
    Colorize.fg_255(77, echo=True)
    Colorize.bg_255(253, echo=True)
    print("That was bad")
    Colorize.reset(echo=True)
"""

class Colorize:
    ESC = "\033["
    BASE_FG = {
        "default"       : 39,
        "black"         : 30,
        "red"           : 31,
        "green"         : 32,
        "yellow"        : 33,
        "blue"          : 34,
        "magenta"       : 35,
        "cyan"          : 36,
        "light gray"    : 37,
        "dark gray"     : 90,
        "light red"     : 91,
        "light green"   : 92,
        "light yellow"  : 93,
        "light blue"    : 94,
        "light magenta" : 95,
        "light cyan"    : 96,
        "white"         : 97,
    }
    BASE_BG = { color_name:code+10 for (color_name, code) in BASE_FG.items() }

    @classmethod
    def esc_code_n(cls, n, echo=False):
        code = f"{cls.ESC}{n}m"
        echo and print(code, end="")
        return code

    @classmethod
    def reset(cls, echo=False):
        code = cls.esc_code_n(0)
        echo and print(code, end="")
        return code

    @classmethod
    def invert(cls, echo=False):
        cls.esc_code_n(7)
        echo and print(code, end="")
        return code

    @classmethod
    def fg(cls, color_name, echo=False):
        "color_name, a value in BASE_FG & BASE_BG"
        n = cls.BASE_FG[color_name.lower()]
        code = cls.esc_code_n(n)
        echo and print(code, end="")
        return code

    @classmethod
    def bg(cls, color_name, echo=False):
        n = cls.BASE_BG[color_name.lower()]
        code = cls.esc_code_n(n)
        echo and print(code, end="")
        return code

    @classmethod
    def fg_255(cls, n, echo=False):
        code = f"{cls.ESC}30;38;5;{n}m"
        echo and print(code, end="")
        return code

    @classmethod
    def bg_255(cls, n, echo=False):
        code = f"{cls.ESC}30;48;5;{n}m"
        echo and print(code, end="")
        return code

    @classmethod
    def print_intro(cls):
        print(
"""INTRO
=====

ESCAPE CODE
-----------
The escape character can be one of the following:
    \\e
    \\033
    \\0x1B

EXAMPLES
--------
Reset:                          \\e[0m
Set base FG or BG to color x:   \\e[xm
Set multiple colors x, y, z:    \\e[x;y;zm

FG to 255 color x:              \\e[38;5;xm
FG to 255 color x:              \\e[48;5;xm
""")

    @classmethod
    def print_base_colors(cls):
        print(f"\nBASE 16 COLORS")
        print(f"==============")
        print(f"\nTerminal Colors  FG#  BG#  Test Pattern")
        print(f"---------------------------------------")
        for color_name, code in cls.BASE_FG.items():
                cls.reset(echo=True)
                print(f"{color_name.title():15}  {code:3}  {code+10:3} ", end="")
                cls.bg(color_name, echo=True)
                cls.fg("white", echo=True); print(" ABCDefgh 01234 ", end="")
                cls.fg("black", echo=True); print(" ABCDefgh 01234 ", end="")
                cls.fg(color_name, echo=True)
                cls.bg("white", echo=True); print(" ABCDefgh 01234 ", end="")
                cls.bg("black", echo=True); print(" ABCDefgh 01234 ", end="")
                cls.reset(echo=True)
                print()

    @classmethod
    def print_255_colors(cls):
        def print_n(n):
            print(f" {n:3} ", end="")
        print(f"\n255 TERMINAL COLORS")
        print(f"=======================================")
        for i in range(0, 255):
            cls.bg_255(i, echo=True)
            cls.fg("white", echo=True); print_n(i)
            cls.fg("black", echo=True); print_n(i)

            cls.fg_255(i, echo=True)
            cls.bg("white", echo=True); print_n(i)
            cls.bg("black", echo=True); print_n(i)
            cls.reset(echo=True)

            set1 = ( i > 0 ) and (i <= 15) and ( (i + 1) % 4 == 0 )
            set2 = (i  > 15) and ( (i - 15) % 6 == 0 )
            if set1 or set2:
                print("")
        print("")

if __name__ == "__main__":
    Colorize.print_intro()
    Colorize.print_base_colors()
    Colorize.print_255_colors()
