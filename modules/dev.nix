{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      editor = {
        line-number = "relative";
        cursorline = true;
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = [ ];
      userSettings = {
        "editor.formatOnSave" = true;
        "editor.cursorBlinking" = "phase";
        "editor.smoothScrolling" = true;
        "window.performance" = "smooth";
      };
    };
    profiles.python = {
      extensions = with pkgs.vscode-marketplace; [
        ms-python.python
        ms-python.vscode-pylance
        charliermarsh.ruff
      ];
      userSettings = {
        "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
        "editor.formatOnSave" = true;
      };
    };
    profiles.java = {
      extensions = with pkgs.vscode-marketplace; [
        vscjava.vscode-java-pack
      ];
    };
    profiles.c-lex = {
      extensions = with pkgs.vscode-marketplace; [
        ms-vscode.cpptools
      ];
    };
    profiles.typst = {
      extensions = with pkgs.vscode-marketplace; [
        myriad-dreamin.tinymist
      ];
    };
  };

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "DotDev262";
      user.email = "dotdev262@gmail.com";
      credential.helper = "store";
      commit.gpgsign = true;
    };
    includes = [
      { path = "~/.config/git/signing_key"; }
    ];
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
  programs.zoxide.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fzf.enable = true;
  programs.lazygit.enable = true;
  programs.bat.enable = true;
  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      # Initialize zoxide
      eval "$(zoxide init bash)"
    '';
    shellAliases = {
      rebuild = "nh os switch";
      hm = "nh home switch";
    };
  };

  home.packages = with pkgs; [
    nil
    git
    gh
    ripgrep
    fd
    eza
    helix
    # Language Tools
    python3
    openjdk
    gcc
    typst

    # New CLI Tools
    just
    lazydocker
    comma
    dust
    alejandra
  ];
}
