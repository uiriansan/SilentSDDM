> [!WARNING]
> This theme requires **SDDM v0.21.0 or newer**. Make sure your distro provides the correct version before installing.

> [!IMPORTANT]
> Want SilentSDDM to also be available as a lockscreen service? Take a look into [this discussion](https://github.com/uiriansan/SilentSDDM/discussions/78).

https://github.com/user-attachments/assets/dd63c526-34d6-45ec-8a7d-5c29bf08c702

# Presets

<details>
  <summary>configs/default.conf</summary>

https://github.com/user-attachments/assets/3a03e859-c6b9-4c4b-bf7f-ab610b94eb28

</details>

<details>
  <summary>configs/rei.conf</summary>

https://github.com/user-attachments/assets/adc9491c-5078-4fb3-86ea-9b91be151412

</details>

<details>
  <summary>configs/ken.conf</summary>

https://github.com/user-attachments/assets/f0538425-c2e6-450e-9f40-d12b7bdbaa86

</details>

<details>
  <summary>configs/silvia.conf</summary>

https://github.com/user-attachments/assets/c90799f7-52bb-4c90-90db-4890281991c1

</details>

<details>
  <summary>configs/everforest.conf</summary>

<img width="1920" height="1080" alt="everforest" src="https://github.com/user-attachments/assets/36d64bf2-b05e-44cf-8bcc-f055381b216f" />


</details>

<details>
  <summary>configs/catppuccin-latte.conf</summary>
<img src="https://github.com/uiriansan/SilentSDDM/blob/main/docs/previews/catppuccin-latte.png" width="100%" />
</details>

<details>
<summary>configs/catppuccin-frappe.conf</summary>
<img src="https://github.com/uiriansan/SilentSDDM/blob/main/docs/previews/catppuccin-frappe.png" width="100%" />
</details>

<details>
  <summary>configs/catppuccin-macchiato.conf</summary>
<img src="https://github.com/uiriansan/SilentSDDM/blob/main/docs/previews/catppuccin-macchiato.png" width="100%" />
</details>

<details>
  <summary>configs/catppuccin-mocha.conf</summary>
<img src="https://github.com/uiriansan/SilentSDDM/blob/main/docs/previews/catppuccin-mocha.png" width="100%" />
</details>

[`Customization guide`](#Customizing)

# Dependencies

- SDDM ≥ 0.21;
- QT ≥ 6.5;
- qt6-svg;
- qt6-virtualkeyboard
- qt6-multimedia

# Installation
[`Install script`](#Install-script) [`AUR packages for Arch`](#AUR-packages-for-arch) [`NixOS flake`](#NixOS-flake) [`Manual installation`](#Manual-installation) [`Pling/KDE Store`](#plingkde-store)

## Install script
Just clone the repo and run the script:

```bash
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh
```

> [!IMPORTANT]
> Make sure to test the theme before rebooting by running `./test.sh`, otherwise you might end up with a broken login screen. Refer to the [snippets page](https://github.com/uiriansan/SilentSDDM/wiki/Snippets) if something goes wrong and [open an issue](https://github.com/uiriansan/SilentSDDM/issues/new/choose) if you don't find the solution there.

## AUR packages for Arch
If you run Arch Linux, consider installing one of the AUR packages:

##### [`Stable version`](https://aur.archlinux.org/packages/sddm-silent-theme):
```bash
yay -S sddm-silent-theme
```
##### [`Git version`](https://aur.archlinux.org/packages/sddm-silent-theme-git):
```bash
yay -S sddm-silent-theme-git
```
Then, replace the current theme and set the environment variables in `/etc/sddm.conf`:
```bash
sudoedit /etc/sddm.conf

    # Make sure these options are correct:
    [General]
    InputMethod=qtvirtualkeyboard
    GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard

    [Theme]
    Current=silent
```
Finally, test the theme to make sure everything is working:
```bash
cd /usr/share/sddm/themes/silent/
./test.sh
```
> [!IMPORTANT]
> Refer to the [snippets page](https://github.com/uiriansan/SilentSDDM/wiki/Snippets) if something goes wrong and [open an issue](https://github.com/uiriansan/SilentSDDM/issues/new/choose) if you don't find the solution there.


## NixOS flake
For NixOS with flakes enabled, first include this flake into your flake inputs:
```nix
inputs = {
   silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
   };
};
```

Next, import the default nixosModule and set the enable option
```nix
{
  inputs,
  ...
}: {
    imports = [inputs.silentSDDM.nixosModules.default];
    programs.silentSDDM = {
        enable = true;
        theme = "rei";
        # settings = { ... }; see example in module
    };
}
```

That's it! SilentSDDM should now be installed and configured.
You may now run the `test-sddm-silent` executable for testing.
For further configuration read the [module](./nix/module.nix) option descriptions and examples.

> [!NOTE]
> Since the module adds extra dependencies to SDDM, 
> you may need to restart for the theme to work correctly.

### Local development and testing under nix
First git clone the repository and cd into the resulting directory
```bash
git clone https://github.com/uiriansan/SilentSDDM.git
cd SilentSDDM/
```

Now you may make changes to the contents and test them out using the
following

```bash
nix run .#test
```

> [!IMPORTANT]
> Refer to the [snippets page](https://github.com/uiriansan/SilentSDDM/wiki/Snippets) if something goes wrong and [open an issue](https://github.com/uiriansan/SilentSDDM/issues/new/choose) if you don't find the solution there.

## Manual installation

### 1. Install dependencies:

#### Arch Linux

```bash
sudo pacman -S --needed sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
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
./test.sh
```
> [!IMPORTANT]
> Refer to the [snippets page](https://github.com/uiriansan/SilentSDDM/wiki/Snippets) if something goes wrong and [open an issue](https://github.com/uiriansan/SilentSDDM/issues/new/choose) if you don't find the solution there.

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
    InputMethod=qtvirtualkeyboard
    GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard

    [Theme]
    Current=silent
```

## Pling/KDE Store
The theme is also available in [Planet Linux'ing Groups](https://www.pling.com/p/2298627/) & [KDE Store](https://store.kde.org/p/2298627).

# Customizing

The preset configs are located in `./configs/`. To change the active config, edit `./metadata.desktop` and replace the value of `ConfigFile=`:

```bash
ConfigFile=configs/<your_preferred_config>.conf
```

> [!NOTE]
> Changes to the login screen will only take effect when made in `/usr/share/sddm/themes/silent/`. If you've changed things in the cloned directory, copy them with `sudo cp -rf SilentSDDM/. /usr/share/sddm/themes/silent/`

<br/>

You can also create your own config file. There's a guide with the list of available options (there are more than 200 of them xD) in the [wiki](https://github.com/uiriansan/SilentSDDM/wiki/Customizing).

> [!IMPORTANT]
> Don't forget to test the theme after every change by running `./test.sh`, otherwise you might end up with a broken login screen.

There are some extra tips on how to customize the theme on the [snippets page](https://github.com/uiriansan/SilentSDDM/wiki/Snippets).

# Acknowledgements

- [Keyitdev/sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme): inspiration and code reference;
- [Match-Yang/sddm-deepin](https://github.com/Match-Yang/sddm-deepin): inspiration and code reference;
- [qt/qtvirtualkeyboard](https://github.com/qt/qtvirtualkeyboard): code reference;
- [Joyston Judah](https://www.pexels.com/photo/white-and-black-mountain-wallpaper-933054/): background;
- [DesktopHut](https://www.desktophut.com/blue-light-anime-girl-6794): background;
- [MoeWalls](https://moewalls.com/anime/ken-kaneki-tokyo-ghoul-re-3-live-wallpaper/): background;
- [MoeWalls](https://moewalls.com/anime/anime-girl-nissan-silvia-live-wallpaper/): background;
- [iconify.design](https://iconify.design/): icons
