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

log "Cleaning Up"
popd
