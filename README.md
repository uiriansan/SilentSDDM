> [!WARNING]
> **PRE-RELEASE** <br/>
> Bugs are expected. SDDM itself has some [annoying issues](https://github.com/uiriansan/SilentSDDM/issues?q=is%3Aissue%20label%3Asddm-issue) and limitations that make it very hard to create an actual good theme. If you encounter a bug, feel free to [open an issue](https://github.com/uiriansan/SilentSDDM/issues/new/choose). <br/><br/>
> **This theme is very resource-intensive. Use at your own risk.**

<img src="https://github.com/uiriansan/SilentSDDM/blob/main/docs/previews/silent.gif" width="100%" />

# Presets

<details>
  <summary>configs/default.conf</summary>

https://github.com/user-attachments/assets/3a03e859-c6b9-4c4b-bf7f-ab610b94eb28

</details>

<details>
  <summary>configs/blue-light.conf</summary>

https://github.com/user-attachments/assets/adc9491c-5078-4fb3-86ea-9b91be151412

</details>

<details>
  <summary>configs/catppuccin-latte.conf</summary>

https://github.com/user-attachments/assets/adc9491c-5078-4fb3-86ea-9b91be151412

</details>

<details>
  <summary>configs/catppuccin-frappé.conf</summary>

https://github.com/user-attachments/assets/adc9491c-5078-4fb3-86ea-9b91be151412

</details>

<details>
  <summary>configs/catppuccin-macchiato.conf</summary>

https://github.com/user-attachments/assets/adc9491c-5078-4fb3-86ea-9b91be151412

</details>

<details>
  <summary>configs/catppuccin-mocha.conf</summary>

https://github.com/user-attachments/assets/adc9491c-5078-4fb3-86ea-9b91be151412

</details>

# Dependencies

- SDDM ≥ 0.20;
- QT ≥ 6.5;
- qt6-svg;
- qt6-virtualkeyboard
- qt6-multimedia

# Installation

Just run the script:

```bash
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh | bash
```

> [!IMPORTANT]
> Make sure to test the theme before rebooting by running `./test`, otherwise you might end up with a broken login screen.

## Manual installation

### 1. Install dependencies:

#### Arch Linux

```bash
sudo pacman -S --needed sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
```

#### Debian

```bash
sudo apt-get install sddm qt6-svg qt6-virtualkeyboard qt6-multimedia
```

#### Void Linux

```bash
sudo xbps-install sddm qt6-svg qt6-virtualkeyboard qt6-multimedia
```

#### Fedora

```bash
sudo dnf install sddm qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia
```

#### OpenSUSE

```bash
sudo zypper install sddm-qt6 libQt6Svg6 qt6-virtualkeyboard qt6-virtualkeyboard-imports qt6-multimedia qt6-multimedia-imports
```

### 2. Clone this repo:
```bash
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
cd SilentSDDM/
```
> [!NOTE]
> You can also get the compressed files from the [latest release](https://github.com/uiriansan/SilentSDDM/releases/latest).

### 3. Test the theme to make sure you have all dependencies:
```bash
./test
```

### 4. Copy the theme to `/usr/share/sddm/themes/`:
```bash
cd SilentSDDM/
sudo mkdir -p /usr/share/sddm/themes/silent
sudo cp -rf . /usr/share/sddm/themes/silent/
```

### 5. Install the fonts:
```bash
sudo cp -r /usr/share/sddm/themes/silent/fonts/* /usr/share/fonts/
```

### 6. Replace the current theme and set the environment variables in `/etc/sddm.conf`:
```bash
sudoedit /etc/sddm.conf

# Make sure these options are correct:
[General]
GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard
InputMethod=qtvirtualkeyboard

[Theme]
Current=silent
```

# Customizing

The preset configs are located in `./configs/`. To change the active config, edit the `./metadata.desktop` file and replace the value of `ConfigFile=`:

```bash
ConfigFile=configs/<your_preferred_config>.conf
```

> [!NOTE]
> Changes to the login screen will only take effect when made in `/usr/share/sddm/themes/silent/`. If you've changed things in the cloned directory, copy them with `sudo cp -rf SilentSDDM/. /usr/share/sddm/themes/silent/`

<br/>

You can also create your own config file. There's a guide with the list of available options (there are 200 of them xD) in the [wiki](https://github.com/uiriansan/SilentSDDM/wiki/Customizing).

> [!IMPORTANT]
> Don't forget to test the theme after every change by running `./test`, otherwise you might end up with a broken login screen.

# Acknowledgements

- [Keyitdev/sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme): inspiration and code reference;
- [Match-Yang/sddm-deepin](https://github.com/Match-Yang/sddm-deepin): inspiration and code reference;
- [qt/qtvirtualkeyboard](https://github.com/qt/qtvirtualkeyboard): code reference;
- [Joyston Judah](https://www.pexels.com/photo/white-and-black-mountain-wallpaper-933054/): background;
- [DesktopHut](https://www.desktophut.com/blue-light-anime-girl-6794): background;
- [iconify.design](https://iconify.design/): icons

I couldn't find the source for some of the images used here. [E-mail me](mailto:uiriansan@gmail.com?subject=Background%20image%20in%20SilentSDDM) if you are the creator and want it removed or acknowledged.
