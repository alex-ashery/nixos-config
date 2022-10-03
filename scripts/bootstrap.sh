#!/bin/sh

log () {
  echo \<\<\<\<$1\>\>\>\>
}

log "Starting bootstrap"
pushd $HOME

log "Running nix install"
curl -L https://nixos.org/nix/install | sh

log "Adding home-manager channel"
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

log "Installing home-manager"
nix-shell '<home-manager>' -A install

log "Cleaning Up"
popd
