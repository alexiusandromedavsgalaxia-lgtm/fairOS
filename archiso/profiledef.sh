#!/usr/bin/env bash
iso_name="fairos"
iso_label="FAIROS_100"
iso_publisher="FairOS Project"
iso_application="FairOS GNOME 50"
iso_version="$(date -u +%Y.%m.%d)"
install_dir="arch"
buildmodes=("iso")
bootmodes=("bios.syslinux" "uefi.grub")
arch="x86_64"

pacman_conf="pacman.conf"
