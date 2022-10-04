#!/bin/sh

log () {
  echo \<\<\<\<$1\>\>\>\>
}

log "Setting up"
pushd $HOME

log "Adding home-manager channel"
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

log "Installing home-manager"
nix-shell '<home-manager>' -A install

log "initializing home-manager"
nix-env -i git
git clone https://github.com/alex-ashery/dotfilesV2.git $HOME/dotfiles
ln -f -s $HOME/dotfiles/home.nix  $HOME/.config/nixpkgs/home.nix
home-manager switch

log "Cleaning Up"
popd
