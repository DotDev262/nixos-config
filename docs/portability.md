# Home Manager Portability Guide

Your configuration is designed to be highly portable, allowing you to take your development environment, terminal tools, and GNOME desktop settings to any other Linux distribution (Ubuntu, Arch, Fedora, etc.) with minimal changes.

## **Portability Principles**
1.  **Dynamic Paths**: Username and home directory are parameterized.
2.  **Explicit Symlinking**: GNOME extensions are manually linked for non-NixOS compatibility.
3.  **Cross-Distro Libraries**: Necessary user-space libraries (like `libsecret`) are included in the Home Manager profile.

---

## **Key Portable Components**

### **1. Dynamic User Configuration**
In `flake.nix`, the `username` and `homeDirectory` are defined as top-level variables and passed to all modules. 
- **To adapt for a new machine**: Simply change these two lines in `flake.nix` and run `home-manager switch`.

### **2. GNOME Extension Portability**
GNOME expects extensions to be in `~/.local/share/gnome-shell/extensions/`. On NixOS, this is handled automatically. On other distros, we use `home.file` symlinks in `modules/gnome.nix` to force-link extensions from the Nix store into your local directory.

### **3. Git Credential Management**
The `credential.helper = "libsecret"` setting in `modules/dev.nix` is supported by including `pkgs.libsecret` in the `home.packages` list, ensuring your GitHub credentials work even if the host distro's version of `libsecret` is missing.

---

## **Using on a Non-NixOS Distro**

### **Step 1: Install Nix & Home Manager**
Follow the official instructions to install the Nix package manager and Home Manager on your host distribution.

### **Step 2: Install Graphics Support (Optional but Recommended)**
To ensure GUI apps (browsers, VS Code) can see your host's GPU, install **[nix-system-graphics](https://github.com/nix-community/nix-system-graphics)**. This is a one-time setup that solves the "nixGL" issue by creating the necessary symlinks on your host system.

### **Step 3: Build Your Configuration**
Run the switch command targeting your flake:
```bash
home-manager switch --flake .#your-username
```

---

## **Limitations (Non-Portable Items)**
- **System Services**: Modules like `fprintd.nix` or TLP settings are NixOS-specific and will not apply to other distros.
- **PAM Configuration**: PAM and Polkit rules are managed by the host OS on non-NixOS systems.
- **Kernel Drivers**: Hardware-specific patches (like the fingerprint driver) must be handled by the host OS.
