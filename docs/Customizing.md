## Using presets

The preset configs are located in `./configs/`. To change the active config, edit `./metadata.desktop` and replace the value of `ConfigFile=`:

```bash
ConfigFile=configs/<your_preferred_config>.conf
```

> [!NOTE]
> Changes to the login screen will only take effect when made in `/usr/share/sddm/themes/silent/`. If you've changed things in the cloned directory, copy them with `sudo cp -rf SilentSDDM/. /usr/share/sddm/themes/silent/`

<br/>

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

## Create your own config
Simply create a new `.conf` file under `configs/` and set it as the active config. If an empty/nonexistent file is provided, the default values will be used.

There are more than **TWO HUNDRED** options available for you to tweak. You can modify pretty much every part of the theme by changing their values. `Options` are divided into 21 `categories`. Each category represents an element in the screen (e.g., clock and username).

Categories are defined between `[brackets]`, followed by their respective options in the `option` = `value` format. Here's an example:

```ini
[LockScreen.Date]
display = true
format = dddd, MMMM dd, yyyy
font-family = RedHatDisplay
font-size = 14
font-weight = 600
color = #FFFFFF
margin-top = -15

[LoginScreen.LoginArea.Avatar]
shape = circle
border-radius = 35
active-size = 120
inactive-size = 80
inactive-opacity = 0.35
active-border-size = 0
inactive-border-size = 0
active-border-color = #FFFFFF
inactive-border-color = #FFFFFF
```

<a href="https://github.com/uiriansan/SilentSDDM/wiki/Options">Here's the list of all available options.</a> This list includes default values and brief descriptions for every option. You can also use the <a href="https://github.com/uiriansan/SilentSDDM/blob/main/configs/default.conf">default config</a> for reference.

<br/>

> [!IMPORTANT]
> Don't forget to test the theme after every change by running `./test.sh`, otherwise you might end up with a broken login screen.

There are some extra tips on how to customize the theme on the [snippets page](https://github.com/uiriansan/SilentSDDM/wiki/Snippets).
