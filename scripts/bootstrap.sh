#!/bin/sh

log () {
  echo \<\<\<\<$1\>\>\>\>
}

log "Starting bootstrap"
pushd $HOME

log "Running nix install"
sh <(curl -L https://nixos.org/nix/install) --daemon

log "Pulling install script"
curl -L https://raw.githubusercontent.com/alex-ashery/dotfilesV2/main/scripts/install.sh > install.sh

log "Configuring environment"
chmod 744 install.sh
echo "# Sets the nix path"
echo "export NIX_PATH=\$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:\$NIX_PATH}" >> .bashrc

log "Cleaning up. Please log out, log back in again, and then run install.sh."
popd
