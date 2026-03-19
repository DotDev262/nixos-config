# Secrets Management with agenix

This document explains how to securely handle sensitive information using `agenix`, Age, and your SSH keys.

## **Overview**
- **`agenix`**: A tool for managing secrets in NixOS and Home Manager configurations, allowing you to encrypt secrets with public keys and decrypt them with private keys (like SSH).
- **Age**: A modern encryption tool used by `agenix` for secure secret handling.

---

## **Key Management**
- **SSH Key to Age**: Your standard SSH key (`~/.ssh/id_ed25519`) is used directly by `agenix` for decryption.
- **Identity Paths**: Configured in `secrets.nix`, `age.identityPaths` tells `agenix` which private keys to use for decryption.

---

## **Secret Storage**
- **`secrets/`**: The directory where your encrypted `.age` files are stored.
- **`secrets/secrets.nix`**: The master configuration file for `agenix` that maps public keys to secret files.

---

## **Workflow**

### 1. **Prepare the `secrets/secrets.nix` file**
Define which public keys can decrypt which secrets:
```nix
let
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."; # Your public SSH key
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."; # Your system's SSH host key
in
{
  "example.age".publicKeys = [ user system ];
}
```

### 2. **Encrypt/Edit Secrets**
Use the `agenix` CLI to create or edit secrets:
```bash
# Navigate to the secrets directory
cd secrets
# Edit or create a secret
agenix -e example.age
```
This will open the file in your default editor. After saving, it will be automatically encrypted using the public keys defined in `secrets/secrets.nix`.

### 3. **Reference Secrets in Nix**
In your `secrets.nix` (Home Manager) or system configuration:
```nix
age.secrets.example.file = ./secrets/example.age;
```
The secret will be decrypted to a path (usually `/run/user/$UID/agenix/example` for Home Manager) and can be accessed via `config.age.secrets.example.path`.

## **Accessing Secrets at Runtime**
Secrets are decrypted by agenix to `/run/user/$UID/agenix/<secret-name>` and can be sourced by your shell:

### **Fish Shell**
Automatically sources `GH_TOKEN` if the secret exists:
```fish
if test -f /run/user/(id -u)/agenix/gh-token
  set -gx GH_TOKEN (cat /run/user/(id -u)/agenix/gh-token)
end
```

### **Bash/Zsh**
Add to your shell init:
```bash
if [ -f "/run/user/$(id -u)/agenix/gh-token" ]; then
  export GH_TOKEN=$(cat "/run/user/$(id -u)/agenix/gh-token")
fi
```

The `GH_TOKEN_FILE` session variable is also set to `${HOME}/.config/gh-token` for tools that expect a file path.

---

## **Best Practices**
- **Never Commit Private Keys**: Always keep your SSH private key secure and off Git.
- **Always Commit Encrypted Secrets**: `.age` files and `secrets/secrets.nix` should be committed to Git.
- **Update Public Keys**: If you change your SSH key, update the public keys in `secrets/secrets.nix` and re-encrypt the secrets.
