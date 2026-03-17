# System Architecture

Your NixOS configuration follows a modular and modern flake-based design, separating system-level settings from user-specific Home Manager configurations.

## **Overview**
- **`flake.nix`**: The central entry point for the configuration, orchestrating dependencies and defining the overall system and home configurations.
- **`configuration.nix`**: Handles system-wide settings, user accounts, and hardware optimizations.
- **`home.nix`**: Defines user-specific configuration managed by Home Manager, importing various modules.
- **`modules/`**: Contains specialized configuration files for different aspects of the system.

## **Modules Breakdown**
- **`gnome.nix`**: Manages GNOME-specific settings, `dconf` tweaks, and shell extensions.
- **`browsers.nix`**: Configures Firefox, Vivaldi, and Zen Browser.
- **`dev.nix`**: Consolidates development tools, shell settings, and VSCode profiles.
- **`services.nix`**: Configures Syncthing and Home Manager maintenance tasks.
- **`packages.nix`**: A dedicated space for general application packages.
- **`theming.nix`**: Centralizes the Catppuccin theme configuration.

---

## **Key Design Principles**
- **Modularity**: Components are separated into logical modules for easier maintenance and reusability.
- **Declarative**: All system and user settings are explicitly defined in the configuration files.
- **Reproducible**: The use of Nix flakes ensures that the system can be reproduced exactly on any machine.
- **Decoupled**: System and home configurations are managed independently through flake outputs.
- **Modern Tooling**: Leveraging `nh`, `direnv`, and `sops-nix` for a powerful and efficient development environment.
