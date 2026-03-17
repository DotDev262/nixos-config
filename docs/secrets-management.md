# Secrets Management with sops-nix

This document explains how to securely handle sensitive information like GPG key IDs using `sops-nix`, Age, and GPG.

## **Overview**
- **`sops-nix`**: A tool for managing secrets in NixOS configurations, allowing you to encrypt and decrypt secrets on the fly.
- **Age**: A modern encryption tool used by `sops` for secure secret handling.
- **GPG**: Used for signing commits and securing sensitive data.

---

## **Key Management**
- **SSH Key to Age Key**: Your SSH key (`~/.ssh/id_ed25519`) is converted to an Age key for secure secret encryption.
- **Age Private Key**: Stored at `~/.config/sops/age/keys.txt`. This is your "Master Key"—never share it or commit it.
- **Age Public Key**: Used in `.sops.yaml` to define encryption rules for your secrets.

---

## **Secret Storage**
- **`secrets.yaml`**: The encrypted secret store. All sensitive data should be stored here.
- **`.sops.yaml`**: Defines encryption rules using your Age public key.

---

## **Workflow**
1.  **Generate Age Private Key**:
    ```bash
    mkdir -p ~/.config/sops/age
    nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt"
    ```
2.  **Encrypt/Edit Secrets**:
    ```bash
    nix-shell -p sops --run "sops secrets.yaml"
    ```
    This will open the file in your default editor. After saving, it will automatically be encrypted.
3.  **Reference Secrets in Nix**:
    Use `config.sops.secrets.gpg_key.path` to access the decrypted value in your configuration.

---

## **Best Practices**
- **Never Commit Private Keys**: Always keep your Age private key secure and off Git.
- **Always Commit Encrypted Secrets**: `secrets.yaml` and `.sops.yaml` should be committed to Git.
- **Verify Encryption**: Before staging `secrets.yaml`, ensure you see the `ENC[AES256_GCM,...]` tags.
- **Use GPG for Commit Signing**: Your GPG key ID is securely managed by `sops-nix` and automatically integrated into your Git configuration.
