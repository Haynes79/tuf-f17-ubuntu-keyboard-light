# kbd-color

Tiny keyboard light controller for ASUS laptops (tested target: TUF Gaming F17 FX706HF).
Uses the kernel's `asus-wmi` sysfs interface at `/sys/class/leds/asus::kbd_backlight/`. No daemon, no dependencies beyond Python 3 (and GTK 4 + libadwaita, already on Ubuntu GNOME, for the settings app).

## Install

    ./install.sh      # symlinks kbd-color into ~/.local/bin, adds login autostart + a "Keyboard Light" app menu entry, installs a udev rule (sudo)
    ./uninstall.sh

The udev rule makes the light files writable by the `plugdev` group, so no sudo is needed at runtime.

## Use

    kbd-color red              # solid colour by name
    kbd-color ff8800           # solid colour by hex
    kbd-color rainbow          # effects: static breathe cycle rainbow
    kbd-color breathe cyan slow
    kbd-color brightness 2     # 0-3
    kbd-color off | on
    kbd-color gui              # settings app (libadwaita): effect, colour, speed, brightness
    kbd-color apply            # re-apply saved setting (run at login)

The last setting is saved to `~/.config/kbd-color.json`.

## Layout

    kbd-color                  the whole program
    udev/99-kbd-color.rules    permission rule
    install.sh / uninstall.sh
