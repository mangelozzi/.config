#!/bin/python
"""A class for colorizing the terminal colors
Refer to : https://misc.flogisoft.com/bash/tip_colors_and_formatting

Example Uwsage:
    import Colorize
    Colorize.set_fg("red")
    Colorize.set_bg("white")
    print("Warning!")
    Colorize.set_fg_255(77)
    Colorize.set_bg_255(253)
    print("That was bad")
    Colorize.reset()
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
    def set_color_n(cls, n):
        print(f"{cls.ESC}{n}m", end="")

    @classmethod
    def reset(cls):
        cls.set_color_n(0)

    @classmethod
    def invert(cls):
        cls.set_color_n(7)

    @classmethod
    def set_fg(cls, color_name):
        "color_name, a value in BASE_FG & BASE_BG"
        n = cls.BASE_FG[color_name.lower()]
        cls.set_color_n(n)
        print(f"{cls.ESC}{n}m", end="")

    @classmethod
    def set_bg(cls, color_name):
        n = cls.BASE_BG[color_name.lower()]
        cls.set_color_n(n)

    @classmethod
    def set_fg_255(cls, n):
        print(f"{cls.ESC}30;38;5;{n}m", end="")

    @classmethod
    def set_bg_255(cls, n):
        print(f"{cls.ESC}30;48;5;{n}m", end="")

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
                cls.reset()
                print(f"{color_name.title():15}  {code:3}  {code+10:3} ", end="")
                cls.set_bg(color_name)
                cls.set_fg("white"); print(" ABCDefgh 01234 ", end="")
                cls.set_fg("black"); print(" ABCDefgh 01234 ", end="")
                cls.set_fg(color_name)
                cls.set_bg("white"); print(" ABCDefgh 01234 ", end="")
                cls.set_bg("black"); print(" ABCDefgh 01234 ", end="")
                cls.reset()
                print()

    @classmethod
    def print_255_colors(cls):
        def print_n(n):
            print(f" {n:3} ", end="")
        print(f"\n255 TERMINAL COLORS")
        print(f"=======================================")
        for i in range(0, 255):
            cls.set_bg_255(i)
            cls.set_fg("white"); print_n(i)
            cls.set_fg("black"); print_n(i)

            cls.set_fg_255(i)
            cls.set_bg("white"); print_n(i)
            cls.set_bg("black"); print_n(i)
            cls.reset()

            set1 = (i <= 15) and ( i % 4 == 0 )
            set2 = (i  > 15) and ( (i - 16) % 6 == 0 )
            if set1 or set2:
                print("")
        print("")

if __name__ == "__main__":
    Colorize.print_intro()
    Colorize.print_base_colors()
    Colorize.print_255_colors()
