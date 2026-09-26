#!/bin/sh
# Remove everything install.sh set up (the project folder itself is left alone).
rm -f "$HOME/.local/bin/kbd-color" \
      "$HOME/.config/autostart/kbd-color.desktop" \
      "$HOME/.local/share/applications/local.kbdcolor.KbdColor.desktop"
if [ -t 0 ]; then ROOT=sudo; else ROOT=pkexec; fi
$ROOT sh -c "rm -f /etc/udev/rules.d/99-kbd-color.rules && udevadm control --reload"
echo "removed"
