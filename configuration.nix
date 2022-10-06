{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "aashery-desktop";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.utf8";

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    displayManager = {
      lightdm.greeters.mini = {
          enable = true;
          user = "aashery";
          extraConfig = ''
            [greeter]
            show-password-label = false
          '';
      };
      defaultSession = "none+home-manager";
      session = [
        {
          manage = "window";
          name = "home-manager";
          start = ''
            ${pkgs.runtimeShell} $HOME/config/.hm-xsession &
            waitPID=$!
          '';
        }
      ];
    };
    windowManager.awesome.enable = true;
  };

  users.users.aashery = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  #  vim
  #  wget
  ];

  system.stateVersion = "22.05";
}
