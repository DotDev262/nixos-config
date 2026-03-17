{
  description = "A basic NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, catppuccin, nix-vscode-extensions, sops-nix, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ nix-vscode-extensions.overlays.default ];
    };
  in {
    nixosConfigurations = {
      thinkpad-E14 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit self;
          inherit sops-nix;
        };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
    };

    homeConfigurations = {
      aryan = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = {
          inherit self;
          inherit zen-browser;
          inherit sops-nix;
        };
        modules = [ 
          ./home.nix 
          catppuccin.homeModules.catppuccin
          sops-nix.homeManagerModules.sops
        ];
      };
    };
  };
}
