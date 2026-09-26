#!/bin/sh
# Remove everything install.sh set up (the project folder itself is left alone).
rm -f "$HOME/.local/bin/kbd-color" \
      "$HOME/.config/autostart/kbd-color.desktop" \
      "$HOME/.local/share/applications/kbd-color.desktop"
sudo rm -f /etc/udev/rules.d/99-kbd-color.rules
sudo udevadm control --reload
echo "removed"
