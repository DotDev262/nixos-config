#!/usr/bin/env bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (sudo bash optimize-power.sh)"
  exit 1
fi

echo "--- 1. Switching from PPD to TLP (Avoid Conflicts) ---"
systemctl stop power-profiles-daemon 2>/dev/null
systemctl mask power-profiles-daemon 2>/dev/null
pacman -S --needed --noconfirm tlp tlp-rdw powertop brightnessctl
systemctl enable --now tlp

echo "--- 2. Configuring TLP for AMD Zen 4 (ThinkPad E14 Gen 5) ---"
# Back up existing config if it hasn't been backed up yet
[ ! -f /etc/tlp.conf.bak ] && cp /etc/tlp.conf /etc/tlp.conf.bak

# Write aggressive AMD P-State and Power settings
cat <<EOF > /etc/tlp.conf
# TLP Optimization for ThinkPad E14 Gen 5 AMD
TLP_ENABLE=1

# CPU Scaling (amd_pstate_epp)
AMD_ENERGY_PERF_PREF_ON_AC=balance_performance
AMD_ENERGY_PERF_PREF_ON_BAT=power
# Fallback key for some TLP versions
CPU_ENERGY_PERF_POLICY_ON_BAT=power
CPU_HWP_DYN_POWER_MANAGEMENT_ON_BAT=power

# Disable Boost on Battery
CPU_BOOST_ON_AC=1
CPU_BOOST_ON_BAT=0

# Allow CPU to downclock to absolute minimum
CPU_SCALING_MIN_FREQ_ON_BAT=410959

# Platform Profile (ThinkPad Specific)
PLATFORM_PROFILE_ON_AC=performance
PLATFORM_PROFILE_ON_BAT=low-power

# Battery Charge Thresholds (Save Battery Health)
START_CHARGE_THRESH_BAT0=75
STOP_CHARGE_THRESH_BAT0=80

# Connectivity & Audio Power Savings
WIFI_PWR_ON_AC=off
WIFI_PWR_ON_BAT=on
SOUND_QUERY_CHIPS=1

# Disk Power Savings
DISK_DEVICES="nvme0n1"
DISK_APM_LEVEL_ON_AC="254 254"
DISK_APM_LEVEL_ON_BAT="128 128"
EOF

echo "--- 3. Creating and Enabling Powertop Auto-Tune Service ---"
if [ ! -f /etc/systemd/system/powertop.service ]; then
cat <<EOF > /etc/systemd/system/powertop.service
[Unit]
Description=Powertop tunings

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
fi
systemctl enable --now powertop.service

echo "--- 3b. Enabling TLP Compatibility Service (tlp-pd) ---"
systemctl enable --now tlp-pd.service

echo "--- 4. Applying Kernel Parameter (Lazy RCU) ---"
if [ -f /etc/default/grub ]; then
    if ! grep -q "rcutree.enable_rcu_lazy=1" /etc/default/grub; then
        sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="rcutree.enable_rcu_lazy=1 /' /etc/default/grub
        grub-mkconfig -o /boot/grub/grub.cfg
        echo "Added Lazy RCU to GRUB. Please reboot to apply."
    fi
fi

echo "--- 5. Finalizing ---"
tlp start
echo "DONE! Your ThinkPad E14 is now using Maximum Power Saving on battery."
echo "TIP: Use 'tlp-stat -p' to verify your AMD P-State EPP settings."
