{ config, pkgs, lib, username, homeDirectory, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      hm = "cd /home/aryan/nixos-config && $HOME/.nix-profile/bin/home-manager switch --flake .#aryan -b backup";
    hms = "cd /home/aryan/nixos-config && nh home switch --backup-extension backup";
      hmn = "home-manager news --flake /home/aryan/nixos-config#aryan";
      zen = "nixGLIntel zen";
      vivaldi = "nixGLIntel vivaldi";
    };
    functions = {
      sudopath = "sudo env \"PATH=$PATH\" $argv";
    };
    interactiveShellInit = ''
      set -g fish_greeting
      if test -f /run/user/(id -u)/agenix/gh-token
        set -gx GH_TOKEN (cat /run/user/(id -u)/agenix/gh-token)
      end
    '';
  };

  programs.bash.shellAliases = {
    hm = "cd /home/aryan/nixos-config && home-manager switch --flake .#aryan -b backup";
    hms = "cd /home/aryan/nixos-config && nh home switch --backup-extension backup";
    hmn = "home-manager news --flake /home/aryan/nixos-config#aryan";
    zen = "nixGLIntel zen";
    vivaldi = "nixGLIntel vivaldi";
  };
}
