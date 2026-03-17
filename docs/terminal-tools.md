# Terminal Tools Quick Reference

Your terminal environment is optimized for speed and productivity with a suite of modern CLI tools.

## **Navigation & Search**
- **`zoxide`**: A smarter `cd` command. Use `z <query>` to jump to directories quickly.
- **`fzf`**: A fuzzy finder for your terminal. Use `Ctrl+R` for history search and `Alt+C` for directory switching.
- **`ripgrep` (`rg`)**: A blazing-fast search tool for your files.
- **`fd`**: A faster and more user-friendly alternative to `find`.

---

## **Development & System Management**
- **`nh` (Nix Helper)**: A modern CLI wrapper for Nix commands.
    - **`nh os switch`**: Rebuild your system configuration.
    - **`nh home switch`**: Update your Home Manager settings.
- **`lazygit`**: A terminal-based UI for Git. Run `lazygit` to manage your repos.
- **`lazydocker`**: A terminal-based UI for Docker. Run `lazydocker` to manage your containers.
- **`bat`**: A modern `cat` with syntax highlighting and Git integration.
- **`tealdeer` (`tldr`)**: Fast, practical man-page summaries. Run `tldr <command>` for examples.

---

## **Utility Tools**
- **`eza`**: A modern `ls` with colors and icons.
- **`dust`**: A visual disk usage tool. Run `dust` to see what's eating your space.
- **`comma` (`,`)**: Run any Nix package instantly without installing it (e.g., `, cowsay hello`).
- **`alejandra`**: An uncompromising Nix code formatter.
- **`pre-commit`**: Automatically runs code formatters and linters before committing.
- **`gh` (GitHub CLI)**: Manage your GitHub repos and pull requests from the terminal.

---

## **Power-User Aliases**
- **`rebuild`**: Aliased to `nh os switch`.
- **`hm`**: Aliased to `nh home switch`.
- **`FLAKE`**: Environment variable pointing to your configuration directory.
