#!/bin/sh
# Remove everything install.sh set up (the project folder itself is left alone).
systemctl --user disable --now kbd-color.service 2>/dev/null
rm -f "$HOME/.config/systemd/user/kbd-color.service" "$HOME/.local/bin/kbd-color" \
      "$HOME/.config/autostart/kbd-color.desktop" \
      "$HOME/.local/share/applications/local.kbdcolor.KbdColor.desktop"
if [ -t 0 ]; then ROOT=sudo; else ROOT=pkexec; fi
$ROOT sh -c "rm -f /etc/udev/rules.d/99-kbd-color.rules && udevadm control --reload"
echo "removed"
