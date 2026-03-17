{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    settings = {
      gui = { address = "127.0.0.1:8384"; };
    };
  };

  services.home-manager.autoExpire = {
    enable = true;
    timestamp = "-7 days";
  };
}
