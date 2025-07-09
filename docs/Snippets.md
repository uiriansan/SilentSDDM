# Enable passwordless login
1. Create a new group called `nopasswdlogin`:
```bash
sudo groupadd -r nopasswdlogin
```
2. Add the user to the group:
```bash
sudo gpasswd -a <username> nopasswdlogin
```
3. Remove the password from the user:
```bash
sudo passwd -d <username>
```
4. Edit `/etc/passwd`, remove 'x' in password field for the user in question (so that it's actually empty):
```bash
sudoedit /etc/passwd

    # From this:
    <username>:x:1003:1003:x:/home/<username>:/usr/bin/bash
               ^

    # ...to this:
    <username>::1003:1003:x:/home/<username>:/usr/bin/bash
```
Thanks to [tpecar](https://github.com/sddm/sddm/issues/751#issuecomment-847347450) for figuring this out.

5. Add the following lines to `/etc/pam.d/sddm` (make sure not to duplicate lines):
```bash
sudoedit /etc/pam.d/sddm

    # Add this to the beginning of the file:
    #%PAM-1.0
    auth        sufficient  pam_succeed_if.so user ingroup nopasswdlogin
    auth        include     system-login
```

The theme should now hide the password input if you select the user. You can test this by running `./test`.

# Change user face (avatar)
There is a script included with the theme:
```bash
./change_avatar <username> <path_to_image_file>
```

...or if you run NixOS:
```nix
systemd.tmpfiles.rules = let
  user = "yourUserName";
  iconPath = ./path/to/icon;
in [
  "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
  "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
];
```
This will set the image as the avatar for the user.

# Extract frame from video
There is a script included with the theme:
```bash
cd backgrounds/
./extract_first_frame.sh <background_video>
```
This will extract the first frame from the video and save it as an image in `./backgrounds/`. You can then use it as the <a href="https://github.com/uiriansan/SilentSDDM/wiki/Options#animatedbackgroundplaceholder">animated-background-placeholder</a>.

# Fix segmentation fault on Nvidia GPU:
If `./test.sh` seg faults, try running this instead:
```bash
QT_IM_MODULE=qtvirtualkeyboard QML2_IMPORT_PATH=./components/ LIBVA_DRIVER_NAME= QT_MULTIMEDIA_PREFERRED_PLUGINS= sddm-greeter-qt6 --test-mode --theme .
```
If it works, add `LIBVA_DRIVER_NAME=` and `QT_MULTIMEDIA_PREFERRED_PLUGINS=` to the `GreeterEnvironment` option in `/etc/sddm.conf` as well:
```bash
sudoedit /etc/sddm.conf

    # Append `LIBVA_DRIVER_NAME=` and `QT_MULTIMEDIA_PREFERRED_PLUGINS=` to the end of the line:
    GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard,LIBVA_DRIVER_NAME=,QT_MULTIMEDIA_PREFERRED_PLUGINS=
```