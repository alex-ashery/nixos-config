{ config, lib, pkgs, inputs, ... }:

{
  # localization
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.utf8";

  system.stateVersion = "22.05";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
