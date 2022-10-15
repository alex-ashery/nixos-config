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
    hostName = "aashery-latop";
    networkmanager.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      xkbOptions = "esc:swapcaps";
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = false;
          middleEmulation = true;
          accelSpeed = "0.0";
        };
      };
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
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pcscd.enable = true;
  };

  users.users.aashery = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    usbutils
    v4l-utils
    home-manager
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.light.enable = true;

  sound.mediaKeys.enable = true;

  security.rtkit.enable = true;
  sound.enable = true;
}
