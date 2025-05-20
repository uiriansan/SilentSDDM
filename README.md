> [!CAUTION]
> UNDER DEVELOPMENT

<img src="https://github.com/uiriansan/SilentSDDM/blob/main/wiki/LoginCenter.png" />

# Installation

## Dependencies

- SDDM ≥ 0.20;
- QT ≥ 6.5;
- qt6-svg;
- qt6-virtualkeyboard;

### Installing dependencies:

```bash
# Arch Linux
$ sudo pacman -S --needed sddm qt6-svg qt6-virtualkeyboard

# Debian
$ sudo apt-get install sddm qt6-svg qt6-virtualkeyboard

# Void Linux
$ sudo xbps-install sddm qt6-svg qt6-virtualkeyboard

# Fedora
$ sudo dnf install sddm qt6-qtsvg qt6-qtvirtualkeyboard

# OpenSUSE
$ sudo zypper install sddm-qt6 libQt6Svg6 qt6-virtualkeyboard qt6-virtualkeyboard-imports
```

## Install script

```bash
$ git clone --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh | bash
```

## Manual installation:

...

# Customizing

...

# TODO

- [ ] Better positioning;
- [ ] Animated backgrounds;

# Acknowledgements

- [Match-Yang/sddm-deepin](https://github.com/Match-Yang/sddm-deepin): code reference;
- [Keyitdev/sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme): code reference;
- [Joyston Judah](https://www.pexels.com/photo/white-and-black-mountain-wallpaper-933054/): background;
- [iconify.design](https://iconify.design/): icons

I couldn't find the source for some of the images used here. [E-mail me](mailto:uiriansan@gmail.com?subject=Background%20image%20in%20SilentSDDM) if you are the creator and want it removed or acknowledged.
