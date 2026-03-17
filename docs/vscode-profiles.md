# VSCode Profiles

Your VSCode configuration includes specialized profiles for different programming languages, providing a tailored development experience.

## **Available Profiles**
- **`default`**: Includes basic settings and the Catppuccin theme/icons.
- **`python`**: Optimized for Python development with Python, Pylance, and Ruff.
- **`java`**: Configured with the Full Java Extension Pack.
- **`c-lex`**: Tailored for C and Lex/Flex/Yacc support.
- **`typst`**: Features the Tinymist extension for modern Typst development.

---

## **Switching Profiles**
You can easily switch between profiles in VSCode by clicking the gear icon in the bottom left corner and selecting "Profiles."

## **Customizing Profiles**
To add or modify extensions and settings for a specific profile, edit `modules/dev.nix`.
- **`extensions`**: A list of `nix-vscode-extensions` marketplace packages.
- **`userSettings`**: An attribute set for profile-specific VSCode settings.

---

## **Catppuccin Integration**
The Catppuccin theme and icons are applied globally across all your VSCode profiles through the `catppuccin.vscode.allProfiles.enable = true;` setting in `modules/theming.nix`.

## **Immutable Extensions**
To ensure consistency and reproducibility, `mutableExtensionsDir` is set to `false`. This means that all extensions must be managed through your Nix configuration.

---

## **Adding New Extensions**
To add a new extension to a profile:
1.  Find the extension name in the [nix-vscode-extensions repository](https://github.com/nix-community/nix-vscode-extensions).
2.  Add it to the `extensions` list for the desired profile in `modules/dev.nix`.
3.  Rebuild your Home Manager configuration with `hm`.
