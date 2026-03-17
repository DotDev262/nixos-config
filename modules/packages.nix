{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gemini-cli-bin
    zip
    wl-clipboard
    nerd-fonts.jetbrains-mono
    ente-auth
    zotero
    obsidian
    fastfetch
    gapless
  ];
}
