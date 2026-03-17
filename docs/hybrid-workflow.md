# Hybrid Workflow: Nix (devenv) + Standard Lockfiles

This document explains the recommended "Hybrid Approach" for projects managed with Nix and `devenv`. This workflow ensures a seamless development experience for Nix users while maintaining full compatibility for collaborators on other platforms (like Windows) who may not have Nix installed.

## **The Core Idea**
We use **Nix/devenv** to manage the **Toolchain** (compiler, package manager, and services) and **Standard Tools** to manage the **Libraries** (via lockfiles).

### **Why This is the Best Approach**
1.  **Cross-Platform Compatibility**: A collaborator on Windows can use the standard tools (like `uv`, `pnpm`, or `cargo`) they already know.
2.  **Version Consistency**: Lockfiles (e.g., `uv.lock`, `pnpm-lock.yaml`, `Cargo.lock`) ensure everyone uses the exact same library versions, regardless of their OS.
3.  **Automatic Environment Setup**: Nix users get their entire environment—including databases and system dependencies—instantly via `devenv`.

---

## **Workflow by Language**

### **1. Python (with `uv`)**
*   **Your Nix Side**: `devenv.nix` provides the `uv` and `python` binaries. You run `uv add <package>`, which generates `pyproject.toml` and `uv.lock`.
*   **Their Windows Side**: They install `uv` natively (`uv.exe`). They run `uv sync`. The `uv.lock` ensures they get the same environment as you.

### **2. Node.js (with `pnpm` or `npm`)**
*   **Your Nix Side**: `devenv.nix` provides `node` and `pnpm`. You run `pnpm install`, which generates `pnpm-lock.yaml`.
*   **Their Windows Side**: They install Node.js/pnpm natively. They run `pnpm install`. The `pnpm-lock.yaml` ensures identical `node_modules`.

### **3. Rust (with `cargo`)**
*   **Your Nix Side**: `devenv.nix` provides the Rust toolchain. You run `cargo build`, which generates `Cargo.lock`.
*   **Their Windows Side**: They install `rustup` natively. They run `cargo build`. The `Cargo.lock` ensures the same crate versions.

---

## **Comparing the Experience**

| Feature | Your Nix/devenv Experience | Their Windows Experience |
| :--- | :--- | :--- |
| **Toolchain (Python, GCC, etc.)** | **Automatic.** `devenv` handles it. | **Manual.** They install the binaries once. |
| **Libraries** | **Locked.** Via standard lockfiles. | **Locked.** Via standard lockfiles. |
| **Services (Postgres, Redis)** | **Declarative.** `devenv` starts them. | **Manual.** They use Docker or local installs. |
| **Environment Variables** | **Automatic.** `direnv` loads them. | **Manual.** They use a `.env` file. |

---

## **Best Practices**
1.  **Always Commit Lockfiles**: Never exclude `uv.lock`, `pnpm-lock.yaml`, or `Cargo.lock` from Git. They are the "source of truth" for library versions.
2.  **Use `devenv.nix` for System Deps**: If your project needs `libxml2` or `openssl`, add them to `packages` in `devenv.nix`. For Windows users, you should document that they need to install these manually (e.g., via `vcpkg` or `choco`).
3.  **Provide a `.env.example`**: Since `devenv` sets environment variables automatically, provide a `.env.example` for non-Nix users to manually copy and fill.

---

## **Generating a Dev Container (Optional)**
If a collaborator wants a zero-install experience on Windows/macOS, you can generate a Dev Container:
```bash
devenv devcontainer
```
This allows them to use VS Code's "Remote - Containers" to run your exact Nix environment inside a Docker container.
