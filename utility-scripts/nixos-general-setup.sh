#!/bin/bash

echo "================================================"
echo "===== [NIX SETUP UTILITY SCRIPT BY vs-123] ====="
echo "================================================"
echo ""
echo "* Make sure you've partitioned the disk"

read -p "Are you sure you want to run this? (y/n) " answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
   echo "[INFO FROM SCRIPT] User chose '$answer', exiting..."
   exit 1
fi

set -e

echo "[INFO FROM SCRIPT] User chose '$answer', continuing..."

echo "[INFO FROM SCRIPT] ================================="
echo "[INFO FROM SCRIPT] ===== MAKING FILESYSTEMS... ====="
echo "[INFO FROM SCRIPT] ================================="

mkfs.vfat /dev/sda1 && echo "[INFO FROM SCRIPT] Made /dev/sda1 vfat"
mkfs.ext4 /dev/sda3 && echo "[INFO FROM SCRIPT] Made /dev/sda3 ext4"
mkswap /dev/sda2    && echo "[INFO FROM SCRIPT] Made /dev/sda2 swap"

echo "[INFO FROM SCRIPT] =================================="
echo "[INFO FROM SCRIPT] ===== MOUNTING PARTITIONS... ====="
echo "[INFO FROM SCRIPT] =================================="

mount /dev/sda3 /mnt && echo "[INFO FROM SCRIPT] Mounted root partition"
swapon /dev/sda2 && echo "[INFO FROM SCRIPT] Enabled swap"
mount --mkdir /dev/sda1 /mnt/boot && echo "[INFO FROM SCRIPT] Mounted EFI boot directory"

nixos-generate-config --root /mnt --dir /tmp/config-potato && echo "[INFO FROM SCRIPT] Generated NixOS configuration file"
rm ./hardware-configuration.nix && echo "[INFO FROM SCRIPT] Removed existing hardware-configuration.nix"
cp /tmp/config-potato/hardware-configuration.nix . && echo "[INFO FROM SCRIPT] Copied new hardware-configuration.nix"

echo "[INFO FROM SCRIPT] =========================================="
echo "[INFO FROM SCRIPT] ===== INSTALLING NIXOS FROM FLAKE... ====="
echo "[INFO FROM SCRIPT] =========================================="
nixos-install --flake .#nebnix && echo "[INFO FROM SCRIPT] NixOS was successfully installed!"

read -p "Would you like to set password for user neb? (y/n)" answer

if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
   nixos-enter --root /mnt -c "passwd neb" && echo "[INFO FROM SCRIPT] Successfully set password!"
fi

echo "[INFO FROM SCRIPT] NixOS has been setup!"

echo "==================="
echo "===== THE END ====="
echo "==================="


