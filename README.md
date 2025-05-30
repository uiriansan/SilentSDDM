> [!CAUTION]
> UNDER DEVELOPMENT <br/>
> A beta will be released soon. I discourage you from using this theme until then.

> [!WARNING]
> **PRE-RELEASE** <br/>
> Bugs are expected. SDDM itself has some [annoying issues](https://github.com/uiriansan/SilentSDDM/issues?q=is%3Aissue%20label%3Asddm-issue) and limitations that make it very hard to create an actual good theme. If you encounter a bug, feel free to [open an issue](https://github.com/uiriansan/SilentSDDM/issues/new/choose).

<img src="https://github.com/uiriansan/SilentSDDM/blob/main/previews/silent.gif" width="100%" />

# Presets

<details>
  <summary>configs/default.conf</summary>
    <p float="left">
      <img src="./previews/default_lock.png" width="49%" />
      <img src="./previews/default_login.png" width="49%" />
    </p>
</details>

# Dependencies

- SDDM ≥ 0.20;
- QT ≥ 6.5;
- qt6-svg;
- qt6-virtualkeyboard

# Installation

Just run the script:

```bash
git clone --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh | bash
```

> [!IMPORTANT]
> Make sure to test the theme before rebooting by running `./test`, otherwise you might end up with a broken login screen.

## Manual installation

### 1. Install dependencies:

#### Arch Linux

```bash
sudo pacman -S --needed sddm qt6-svg qt6-virtualkeyboard
```

#### Debian

```bash
sudo apt-get install sddm qt6-svg qt6-virtualkeyboard
```

#### Void Linux

```bash
sudo xbps-install sddm qt6-svg qt6-virtualkeyboard
```

#### Fedora

```bash
sudo dnf install sddm qt6-qtsvg qt6-qtvirtualkeyboard
```

#### OpenSUSE

```bash
sudo zypper install sddm-qt6 libQt6Svg6 qt6-virtualkeyboard qt6-virtualkeyboard-imports
```

> [!NOTE]
> You can also get the compressed files from the [latest release](https://github.com/uiriansan/SilentSDDM/releases/latest).

# Customizing

The preset configs are located in `./configs/`. To change the active config, edit the `./metadata.desktop` file and replace the value of `ConfigFile=`:

```bash
ConfigFile=configs/<your_preferred_config>.conf
```

> [!NOTE]
> Changes to the login screen will only take effect when made in `/usr/share/sddm/themes/silent/`. If you changed things in the cloned directory, copy them with `sudo cp -rf SilentSDDM/. /usr/share/sddm/themes/silent/`

<br/>

You can also create a new config file. There's a detailed guide with the list of available options in the [wiki](https://github.com/uiriansan/SilentSDDM/wiki/Customizing).

> [!IMPORTANT]
> Don't forget to test the theme after every change by running `./test`, otherwise you might end up with a broken login screen.

# Acknowledgements

- [Keyitdev/sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme): inspiration and code reference;
- [Match-Yang/sddm-deepin](https://github.com/Match-Yang/sddm-deepin): inspiration and code reference;
- [qt/qtvirtualkeyboard](https://github.com/qt/qtvirtualkeyboard): code reference;
- [Joyston Judah](https://www.pexels.com/photo/white-and-black-mountain-wallpaper-933054/): background;
- [iconify.design](https://iconify.design/): icons

I couldn't find the source for some of the images used here. [E-mail me](mailto:uiriansan@gmail.com?subject=Background%20image%20in%20SilentSDDM) if you are the creator and want it removed or acknowledged.
