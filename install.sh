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

cat > "$HOME/.local/share/applications/kbd-color.desktop" <<EOT
[Desktop Entry]
Type=Application
Name=Keyboard Light
Comment=Change keyboard colour and effects
Exec=$DIR/kbd-color gui
Icon=input-keyboard
Categories=Settings;HardwareSettings;
EOT

sudo cp "$DIR/udev/99-kbd-color.rules" /etc/udev/rules.d/99-kbd-color.rules
sudo udevadm control --reload
sudo udevadm trigger --subsystem-match=leds --action=add
echo "installed. try: kbd-color red"
