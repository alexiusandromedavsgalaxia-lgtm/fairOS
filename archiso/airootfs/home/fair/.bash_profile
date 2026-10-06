if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ]; then
  sudo -n systemctl start NetworkManager.service >/dev/null 2>&1 || true
  exec dbus-run-session gnome-session
fi
