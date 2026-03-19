# Hardware Optimizations for ThinkPad E14

Your NixOS configuration includes specialized optimizations for your Lenovo ThinkPad E14 (AMD Gen 5), improving performance, stability, and power management.

## **AMD & Power Optimizations**
- **`amd_pstate_epp` (Active Mode)**: The most modern scaling driver for Zen 3/4 processors.
- **TLP Custom Configuration**: Optimized for the Ryzen 5 7530U to ensure maximum battery life:
    - **`EPP = power`**: Forced most aggressive power-saving state on battery.
    - **`CPU_BOOST = 0`**: Disabled boost on battery to prevent power spikes.
    - **`MIN_FREQ = 410MHz`**: Allows the CPU to downclock fully.
    - **`PLATFORM_PROFILE = low-power`**: Firmware-level power saving for ThinkPads.
- **`optimize-power.sh`**: A specialized bash script to automate TLP setup, mask conflicting services (like `power-profiles-daemon`), and apply CachyOS-specific kernel parameters like **Lazy RCU** (`rcutree.enable_rcu_lazy=1`).
- **Powertop Auto-Tune**: Integrated as a systemd service to handle low-level PCIe, USB, and SATA power states.
- **Microphone LED**: Specialized `udev` fix for the ThinkPad microphone LED.

## **Biometric Authentication**
- **FPC Fingerprint Sensor (10a5:9800)**: Specialized support for the Goodix/FPC fingerprint sensor found on the ThinkPad E14.
    - **Proprietary Driver**: Integrated the `libfpcbep.so` driver from Lenovo's official firmware (`r1slm02w.zip`).
    - **Libfprint Patching**: Custom build of `libfprint` with the `fpcmoh` driver patch and TEE database fixes.
    - **Power Management**: Explicitly disabled USB autosuspend for the sensor (10a5:9800) in TLP to prevent "verify-no-match" issues and internal database resets.
    - **Polkit & PAM**: 
        - Configured `fprintAuth` for all critical PAM services (sudo, login, gdm, etc.).
        - Added custom Polkit rules to allow users in the `wheel` group to manage fingerprints without a password prompt, ensuring the menu appears in GNOME Settings.

---

## **SSD Optimization**
- **`services.fstrim.enable`**: Enables automatic SSD trimming to maintain performance and extend the life of your drive.

## **Pipewire for Audio**
- **Pipewire**: Configured as the modern audio backend with ALSA and PulseAudio compatibility, providing high-fidelity and low-latency sound.

---

## **Docker Infrastructure**
- **Docker**: Configured for rootless execution, providing a secure and isolated environment for containerized applications.

## **Boot & Bootloader**
- **GRUB (EFI)**: Configured as the EFI bootloader with OS prober enabled for easy multi-boot management.

---

## **Key Design Principles**
- **Safe Tweaks**: Only universally good and tested optimizations are applied, avoiding any risky hardware-specific workarounds.
- **Declarative**: All hardware settings are explicitly defined in `configuration.nix` and `hardware-configuration.nix`.
- **NixOS-Standardized**: Optimizations follow established NixOS patterns for better compatibility and maintenance.
