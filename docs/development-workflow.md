# Development Workflow

Your NixOS configuration includes a suite of modern development tools for an efficient and reproducible workflow.

## **Key Tools**
- **`devenv`**: A tool for creating isolated, reproducible development environments with ease.
- **`direnv`**: Automatically activates your development environment when you `cd` into a directory.
- **`pre-commit`**: Automatically runs code formatters and linters before committing.
- **`nix flake init`**: Quickly start new projects using standardized templates.

---

## **Starting a New Project**
1.  **Initialize with a Template**:
    ```bash
    nix flake init -t /home/aryan/nixos-config#<template-name>
    ```
2.  **Activate Environment**:
    The environment will automatically be activated when you `cd` into the project directory, thanks to `direnv`.
3.  **Use `devenv` shell**:
    Alternatively, you can manually enter the shell by running:
    ```bash
    devenv shell
    ```

---

## **Managing Development Environments**
- **`devenv init`**: Initialize a new environment in a project directory.
- **`devenv config`**: View and edit the current development environment configuration.
- **`devenv up`**: Run services like databases defined in the configuration.

---

## **Best Practices**
- **Always Use direnv**: It ensures your environment is always up-to-date and consistent.
- **Commit pre-commit Configuration**: Always include `.pre-commit-config.yaml` in your project repos.
- **Use Standardized Templates**: This ensures all your projects follow the same architecture and tooling.
- **Manage Services via devenv**: This makes it easy for others to replicate your exact development environment.
