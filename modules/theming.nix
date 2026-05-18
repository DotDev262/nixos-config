{ config, lib, pkgs, catppuccin, ... }:

let
  fixedPnpmDeps = pkgs.fetchPnpmDeps {
    pname = "catppuccin-vscode";
    version = "3.19.0";
    src = catppuccin.packages.x86_64-linux.vscode.src;
    pnpmWorkspaces = [ "catppuccin-vsc" ];
    fetcherVersion = 3;
    hash = "sha256-a1er5btH6aYRnKgpyW1UU8fgsuZZO72+/JkYSMaYKSg=";
  };
in
{
  catppuccin = {
    enable = true;
    flavor = "mocha";
    helix.enable = true;
    vscode.profiles = {
      default.enable = true;
      python.enable = true;
      java.enable = true;
      c-lex.enable = true;
      typst.enable = true;
    };
  };

  catppuccin.sources = lib.mkForce (
    catppuccin.packages.x86_64-linux
    // {
      vscode = catppuccin.packages.x86_64-linux.vscode.overrideAttrs (old: {
        pnpmDeps = fixedPnpmDeps;
      });
    }
  );
}
