#!/bin/env bash

cat << EOM
    Hello there this is my dotfiles installer script,
    this script will do the following things to the current system:
    1. Set up pacman with my preffered config file
    2. Set up the fastest latest 50 NL mirrors through reflector
    3. Install all my daily driver packages
    4. Install Yay
    5. Install all my daily driver AUR packages
    6. Link all relevant .config files to the ones provided here
    7. Overwrite certain /etc config files
    8. Enable SystemD services
    Press the enter key to continue or <CTRL>+C to cancel..
EOM

read;

# Install packages

source $PWD/scripts/install-packages.sh
xdg-user-dirs-update

# Making sure all directories we need are in palce
mkdir -p $HOME/.local/bin $HOME/.config $HOME/.fonts

# Install fonts
echo "Linking fonts...";

ln -sf $PWD/fonts $HOME/.fonts

# Install config files
echo "Linking config files...";
ln -sf $PWD/config/* $HOME/.config/

ln -sf $PWD/misc/zshrc $HOME/.zshrc
ln -sf $PWD/misc/zshenv $HOME/.zsenv
ln -sf $PWD/misc/xprofile $HOME/.xprofile
ln -sf $PWD/assets/wallpapers $HOME/Pictures

echo "Writing to ETC config files";
cat $PWD/etc/lightdm.conf | sudo tee /etc/lightdm/lightdm.conf
cat $PWD/etc/lightdm-webkit2-greeter.conf | sudo tee /etc/lightdm/lightdm-webkit2-greeter.conf

echo "Change shell to zsh";
chsh -s /bin/zsh

echo "Installing optional packages" 
source $PWD/scripts/install-optional.sh

# Enable services
echo "Enabling all services";
sudo systemctl enable --now lightdm