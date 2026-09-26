#!/bin/sh
# Install kbd-color for the current user. Asks for sudo once, for the udev rule.
set -e
DIR=$(cd "$(dirname "$0")" && pwd)

mkdir -p "$HOME/.local/bin" "$HOME/.config/autostart" "$HOME/.local/share/applications"
ln -sf "$DIR/kbd-color" "$HOME/.local/bin/kbd-color"

cat > "$HOME/.config/autostart/kbd-color.desktop" <<EOT
[Desktop Entry]
Type=Application
Name=Keyboard Light
Exec=$DIR/kbd-color apply
X-GNOME-Autostart-enabled=true
NoDisplay=true
EOT

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
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
echo "installed. Open \"Keyboard Light\" from your app menu, or run: kbd-color red"
