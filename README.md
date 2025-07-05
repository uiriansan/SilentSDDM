> [!WARNING]
> This theme requires **SDDM v0.21**. Make sure your distro provides the correct version before installing.

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
[`Install script`](#Install-script) [`AUR packages for Arch`](#AUR-packages-for-arch) [`NixOS flake`](#NixOS-flake) [`Manual installation`](#Manual-installation)

## Install script
Just clone the repo and run the script:

```bash
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh
```

> [!IMPORTANT]
> Make sure to test the theme before rebooting by running `./test.sh`, otherwise you might end up with a broken login screen. Refer to the [snippets page](https://github.com/uiriansan/SilentSDDM/wiki/Snippets) if something goes wrong and [open an issue](https://github.com/uiriansan/SilentSDDM/issues/new/choose) if you don't find the solution there.

## AUR packages for Arch
If you run Arch Linux, consider installing one of the AUR packages:
```bash
# stable version
yay -S sddm-silent-theme
# git version
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
Then you may configure sddm like so to use the theme:
```nix
{
  pkgs,
  inputs,
  ...
}: let
   # an exhaustive example can be found in flake.nix
   sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
      theme = "rei"; # select the config of your choice
   };
in  {
   # include the test package which can be run using test-sddm-silent
   environment.systemPackages = [sddm-theme sddm-theme.test];
   qt.enable = true;
   services.displayManager.sddm = {
      package = pkgs.kdePackages.sddm; # use qt6 version of sddm
      enable = true;
      theme = sddm-theme.pname;
      # the following changes will require sddm to be restarted to take
      # effect correctly. It is recomend to reboot after this
      extraPackages = sddm-theme.propagatedBuildInputs;
      settings = {
        # required for styling the virtual keyboard
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      };
   };
}
```
The above example includes the test script (`sddm-theme.test`) into your
systemPackages, which lets you test the theme by running `test-sddm-silent`.
However, it is optional and can be omitted

> For a more exhaustive example look at the example package in [flake.nix](https://github.com/uiriansan/SilentSDDM/blob/main/flake.nix).

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

I couldn't find the source for some of the images used here. [E-mail me](mailto:uiriansan@gmail.com?subject=Background%20image%20in%20SilentSDDM) if you are the creator and want it removed or acknowledged.
