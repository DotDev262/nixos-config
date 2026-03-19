{
  description = "A lightweight NixOS MicroVM template";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.microvm.url = "github:astro/microvm.nix";

  outputs = { self, nixpkgs, microvm }: {
    nixosConfigurations.microvm = nixpkgs.lib.nixosSystem {
      pkgs = import nixpkgs { localSystem = "x86_64-linux"; };
      modules = [
        microvm.nixosModules.microvm
        {
          networking.hostName = "sandboxed-vm";
          microvm = {
            volumes = [{
              mountpoint = "/var";
              tag = "journal";
              source = "/var/lib/microvms/sandboxed-vm/journal";
              size = 1024;
            }];
            shares = [{
              tag = "ro-nix-store";
              source = "/nix/store";
              mountpoint = "/nix/store";
            }];
            socket = "control.socket";
          };
          users.users.root.password = "root";
          services.getty.helpLine = "Welcome to your sandboxed NixOS MicroVM!";
        }
      ];
    };
  };
}
