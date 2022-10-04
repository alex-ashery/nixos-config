{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aashery";
  home.homeDirectory = "/home/aashery";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-airline
        vim-fugitive
        vim-surround
      ];

      settings = {
        number = true;
        relativenumber = true;
        expandtab = true;
      };

      extraConfig = builtins.readFile ~/dotfiles/vim/.vimrc;
    };
    git = {
      enable = true;
      userName = "alex-ashery";
      userEmail = "alexander.ashery@gmail.com";
    };
  };
}
