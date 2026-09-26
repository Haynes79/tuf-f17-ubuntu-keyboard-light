#!/bin/sh
# Install kbd-color for the current user. Asks for sudo once, for the udev rule.
set -e
DIR=$(cd "$(dirname "$0")" && pwd)

mkdir -p "$HOME/.local/bin" "$HOME/.config/systemd/user" "$HOME/.local/share/applications"
rm -f "$HOME/.config/autostart/kbd-color.desktop"  # replaced by the systemd service below
ln -sf "$DIR/kbd-color" "$HOME/.local/bin/kbd-color"

cat > "$HOME/.local/share/applications/local.kbdcolor.KbdColor.desktop" <<EOT
[Desktop Entry]
Type=Application
Name=Keyboard Light
Comment=Change keyboard colour and effects
Exec=$DIR/kbd-color gui
Icon=input-keyboard
Categories=Settings;HardwareSettings;
Keywords=keyboard;light;rgb;backlight;
StartupNotify=true
EOT

# Root step: use sudo in a terminal, otherwise a graphical password prompt (pkexec).
if [ -t 0 ]; then ROOT=sudo; else ROOT=pkexec; fi
$ROOT sh -c "cp '$DIR/udev/99-kbd-color.rules' /etc/udev/rules.d/99-kbd-color.rules && udevadm control --reload && udevadm trigger --subsystem-match=leds --action=add"
# Background service: applies your saved setting at login and keeps battery/heat colours live.
cat > "$HOME/.config/systemd/user/kbd-color.service" <<EOT
[Unit]
Description=Keyboard light (kbd-color)

[Service]
ExecStart=$DIR/kbd-color daemon
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOT
systemctl --user daemon-reload
systemctl --user enable kbd-color.service >/dev/null 2>&1 || echo "warning: could not enable the background service"
systemctl --user restart kbd-color.service || echo "warning: could not start the background service"

update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
echo "installed. Open \"Keyboard Light\" from your app menu, or run: kbd-color red"
