{ pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "aashery-desktop";
    networkmanager.enable = true;
  };

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
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
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
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    usbutils
    v4l-utils
    home-manager
  ];

  security.rtkit.enable = true;
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
