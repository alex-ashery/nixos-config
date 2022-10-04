#!/bin/bash

DOTFILES=$HOME/dotfiles

sudo nix-env -i git
git clone https://github.com/alex-ashery/dotfilesV2.git $DOTFILES
sudo nix-env -e git

sudo cp $DOTFILES/configuration.nix /etc/nixos/configuration.nix
HW_CONF=$DOTFILES/machines/$1.nix
if [ ! -f $HW_CONF ]; then
        echo No machine $1 found
        exit 1
fi
sudo cp $HW_CONF /etc/nixos/hardware-configuration.nix
sudo nixos-rebuild switch

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
sudo nix-channel --update
nix-shell <home-manager> -A install
ln -f -s $HOME/dotfiles/home.nix $HOME/.config/nixpkgs/home.nix
home-manager switch
