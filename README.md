# dotfilesV2
home-manager based dotfiles

## Installation
1. Install `nix`:
```
sh <(curl -L https://nixos.org/nix/install)
```

2. Add the `home-manager` channel:
```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
```

3. Install `home-manager`:
```
nix-shell '<home-manager>' -A install
```
