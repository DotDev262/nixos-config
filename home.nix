{ config, pkgs, zen-browser, username, homeDirectory, ... }:

{
  imports = [
    ./modules/gnome.nix
    ./modules/browsers.nix
    ./modules/dev.nix
    ./modules/services.nix
    ./modules/theming.nix
    ./modules/packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  home.sessionVariables = {
    ANI_CLI_PLAYER = "mpv";
    ANI_CLI_SKIP_INTRO = "1";
  };

  programs.home-manager.enable = true;

  home.sessionPath = [ "$HOME/.local/bin" ];

  programs.fish.enable = true;

  programs.fish.shellAliases = {
    hms = "cd /home/aryan/nixos-config && $HOME/.nix-profile/bin/home-manager switch --flake .#aryan -b backup";
  };

  programs.fish.functions = {
    sudopath = "sudo env \"PATH=$PATH\" $argv";
  };

  programs.bash.shellAliases = {
    hms = "home-manager switch -b backup";
  };

  fonts.fontconfig.enable = true;
}
