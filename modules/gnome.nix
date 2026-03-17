{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 1080;
      night-light-schedule-to = 360;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 0;
    };
    "org/gnome/desktop/privacy" = {
      purge-trash = true;
      purge-temp = true;
      old-files-age = 30;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "caffeine@patapon.info"
        "alphabetical-app-grid@stuarthayhurst.shell-extension"
        "pano@alperen.elhan"
      ];
      favorite-apps = [
        "zen.desktop"
        "vivaldi-stable.desktop"
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
      ];
    };
    "org/gnome/shell/extensions/caffeine" = {
      show-notifications = true;
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.caffeine
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.pano
  ];
}
