#!/bin/bash

CONFDIR=/etc/nixos

if [ -d $CONFDIR ]; then
	sudo cp -R $CONFDIR $CONFDIR.old
	sudo rm -rf $CONFDIR
fi
sudo nix-env -i git
sudo git clone https://github.com/alex-ashery/dotfilesV2.git $CONFDIR
sudo nix-env -e git

HW_CONF=$CONFDIR/machines/$1.nix
if [ ! -f $HW_CONF ]; then
        echo No machine $1 found
        exit 1
fi
sudo ln -f -s $HW_CONF $CONFDIR/hardware-configuration.nix
sudo nixos-rebuild switch

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
sudo nix-channel --update
nix-shell '<home-manager>' -A install

USER_CONF=$CONFDIR/users/$2
if [ ! -d $USER_CONF ]; then
        echo No user $2 found
        exit 1
fi

HOME_CONF=$HOME/config
if [ -d $HOME_CONF ]; then
        cp -R $HOME_CONF $HOME_CONF.old
fi
cp -R $USER_CONF $HOME_CONF
ln -f -s $HOME_CONF/home.nix $HOME/.config/nixpkgs/home.nix

home-manager switch
