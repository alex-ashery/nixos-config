#!/bin/sh

log () {
  echo \<\<\<\<$1\>\>\>\>
}

log "Starting bootstrap"
pushd $HOME

log "Running nix install"
curl -L https://nixos.org/nix/install | sh

log "Pulling install script"
curl -L https://raw.githubusercontent.com/alex-ashery/dotfilesV2/main/scripts/install.sh > install.sh

log "Cleaning up. Please log out, log back in again, and then run install.sh."
popd
