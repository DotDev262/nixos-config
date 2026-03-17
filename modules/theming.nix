{ config, pkgs, ... }:

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
}
