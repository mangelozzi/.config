#!/bin/bash

# Print 256 Colors
for i in {0..255} ; do
    # Black FG on color BG
    printf "\e[30;48;5;%sm%4d " "$i" "$i"

    # White FG on color BG
    printf "\e[97m%4d " "$i"

    # Color FG on black BG
    printf "\e[40;38;5;%sm%4d " "$i" "$i"

    # Color FG on white BG
    printf "\e[107m%4d " "$i"

    # Check whether to print new line
    [ $(( ($i +  1) % 4 )) == 0 ] && set1=1 || set1=0
    [ $(( ($i - 15) % 6 )) == 0 ] && set2=1 || set2=0
    if ( (( set1 == 1 )) && (( i <= 15 )) ) || ( (( set2 == 1 )) && (( i > 15 )) ); then
        printf "\e[0m\n";
    fi
done

# Code    Color   Example Preview
echo -e "\e[0m39  Default foreground color    Default \e[39mDefault" Default Default
echo -e "\e[0m30  Black           Default \e[30mBlack" Default Black
echo -e "\e[0m31  Red             Default \e[31mRed" Default Red
echo -e "\e[0m32  Green           Default \e[32mGreen" Default Green
echo -e "\e[0m33  Yellow          Default \e[33mYellow" Default Yellow
echo -e "\e[0m34  Blue            Default \e[34mBlue" Default Blue
echo -e "\e[0m35  Magenta         Default \e[35mMagenta" Default Magenta
echo -e "\e[0m36  Cyan            Default \e[36mCyan" Default Cyan
echo -e "\e[0m37  Light gray      Default \e[37mLight gray" Default Light gray
echo -e "\e[0m90  Dark gray       Default \e[90mDark gray" Default Dark gray
echo -e "\e[0m91  Light red       Default \e[91mLight red" Default Light red
echo -e "\e[0m92  Light green     Default \e[92mLight green" Default Light green
echo -e "\e[0m93  Light yellow    Default \e[93mLight yellow" Default Light yellow
echo -e "\e[0m94  Light blue      Default \e[94mLight blue" Default Light blue
echo -e "\e[0m95  Light magenta   Default \e[95mLight magenta" Default Light magenta
echo -e "\e[0m96  Light cyan      Default \e[96mLight cyan" Default Light cyan
echo -e "\e[0m97  White           Default \e[97mWhite" Default White
