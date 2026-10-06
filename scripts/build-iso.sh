#!/usr/bin/env bash
set -euo pipefail

# FairOS ISO builder
root_dir="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$root_dir/out"

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required" >&2
  exit 1
fi

docker run --rm --privileged   -e TZ=UTC   -v "$root_dir:/src"   archlinux:latest   bash -euo pipefail -c '
    pacman -Syu --noconfirm --needed archiso rsync
    mkdir -p /tmp/fairos-profile /tmp/fairos-work
    cp -a /usr/share/archiso/configs/releng/. /tmp/fairos-profile/
    cp /src/archiso/profiledef.sh /tmp/fairos-profile/profiledef.sh
    cp /src/archiso/packages.x86_64 /tmp/fairos-profile/packages.x86_64
    cp /src/archiso/pacman.conf /tmp/fairos-profile/pacman.conf
    cp -a /src/archiso/airootfs/. /tmp/fairos-profile/airootfs/
    mkarchiso -v -w /tmp/fairos-work -o /src/out /tmp/fairos-profile
  '

find "$root_dir/out" -maxdepth 1 -name "*.iso" -print -quit | grep .
