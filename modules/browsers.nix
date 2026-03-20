{ config, pkgs, lib, zen-browser, system, ... }:

{
  programs.firefox.enable = lib.mkForce false;


  programs.vivaldi = {
    enable = true;
    commandLineArgs = [
      "--disk-cache-size=0"
      "--media-cache-size=1048576"
    ];
  };

  home.packages = [
    zen-browser.packages.${system}.default
    pkgs.vivaldi-ffmpeg-codecs
  ];
}
