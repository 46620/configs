#!/bin/bash

# This script will be used until I find a hardware solution

# Script to select what to start in a custom built arcade cabinet
# All this shit is basically stolen from https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script but done in a slightly cleaner way

#TODO:
# Fix update function
# Make code a bit cleaner and easier to read

vars() {
    HEIGHT=15
    WIDTH=40
    CHOICE_HEIGHT=6
    BACKTITLE="46620 menu v0.0.1a"
    TITLE="ARCADE BOOT MENU"
    MENU="What would you like to play?"
    OPTIONS=(1 "ES-DE"
         2 "Clone Hero"
         3 "Operator Settings"
         4 "Shutdown")
}

function game_select() {
    case $GAME in
        1) kwin_wayland --exit-with-session emulationstation;;
        2) kwin_wayland --exit-with-session clonehero;;
        3) operator;;
        4) shutdown 0;;
    esac
}

function operator() {
    OPTIONS=(1 "Update"
         2 "CLI")

    OPERATE=$(DIALOGRC=arcade.dialog dialog --clear \
           --backtitle "$BACKTITLE" \
           --title "$TITLE" \
           --menu "$MENU" \
           $HEIGHT $WIDTH $CHOICE_HEIGHT \
           "${OPTIONS[@]}" \
           2>&1 >/dev/tty)
    
    case $OPERATE in
        1) update;;
        2) clear && exit 0;;
    esac
}

function menu() {
    GAME=$(DIALOGRC=arcade.dialog dialog --clear \
           --backtitle "$BACKTITLE" \
           --title "$TITLE" \
           --menu "$MENU" \
           $HEIGHT $WIDTH $CHOICE_HEIGHT \
           "${OPTIONS[@]}" \
           2>&1 >/dev/tty)
}


function update() {
    clear
    echo "This feature is not added yet, please contact Mia for updates"
    exit 1
}

function build_config() {
    # This function is just so I don't need to supply this file myself
    # And yes, this runs every single run, it's in case I update it in the future.
    dialog --create-rc arcade.dialog
    sed -i 's@screen_color = (CYAN,BLUE,ON)@screen_color = (CYAN,BLACK,ON)@g' arcade.dialog
    sed -i 's@border_color = (WHITE,WHITE,ON)@border_color = (WHITE,BLACK,ON)@g' arcade.dialog
    sed -i 's@dialog_color = (BLACK,WHITE,OFF)@dialog_color = (WHITE,BLACK,OFF)@g' arcade.dialog
    sed -i 's@title_color = (BLUE,WHITE,ON)@title_color = (BLUE,BLACK,ON)@g' arcade.dialog
    sed -i 's@button_key_inactive_color = (RED,WHITE,OFF)@button_key_inactive_color = (RED,BLACK,OFF)@g' arcade.dialog
    sed -i 's@button_label_inactive_color = (BLACK,WHITE,ON)@button_label_inactive_color = (WHITE,BLACK,ON)@g' arcade.dialog
}

main() {
    build_config
    vars
    menu
    game_select
    main
}

main