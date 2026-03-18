# NixOS Configuration Wiki

Welcome to your personal NixOS configuration wiki! This documentation serves as a comprehensive reference for your system architecture, development workflows, and secret management.

## **Navigation**
- **[Architecture](./architecture.md)**: Understand the modular, flake-based design of your configuration.
- **[Secrets Management](./secrets-management.md)**: Learn how to securely handle sensitive data using `sops-nix`, Age, and GPG.
- **[Development Workflow](./development-workflow.md)**: A guide to `devenv`, `direnv`, `pre-commit`, and standardized project setups.
- **[Hybrid Workflow](./hybrid-workflow.md)**: How to collaborate with non-Nix users using standard lockfiles.
- **[Terminal Tools](./terminal-tools.md)**: A quick-reference guide for modern CLI tools like `nh`, `fzf`, and `lazygit`.
- **[VSCode Profiles](./vscode-profiles.md)**: How to use and customize language-specific VSCode profiles.
- **[Hardware Optimizations](./hardware-optimizations.md)**: Details on AMD and SSD optimizations for your ThinkPad E14.
- **[Portability Guide](./portability.md)**: How to use your Home Manager configuration on other Linux distributions.

---

## **Quick Commands**
- **Rebuild System**: `rebuild` (aliased to `nh os switch`)
- **Update Home Manager**: `hm` (aliased to `nh home switch`)
- **Check for Secrets**: `sops secrets.yaml`
- **Start Project Env**: `devenv shell`
- **Initialize Template**: `nix flake init -t /home/aryan/nixos-config#<template-name>`
