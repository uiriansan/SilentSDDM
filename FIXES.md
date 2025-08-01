*FIX*: Visual bug with the avatar – if the user uploads an image that is too large, the avatar appears distorted. The code below fixes this and works similarly to the CSS property `object-fit: cover;`.

*FIX*: Visual bug when using any language other than English:
In the shutdown menu, the container collapses and the buttons appear distorted.

### Solution:
- Adapted button text width and enabled line wrapping into 2 lines for long text;
- Menu no longer collapses (`implicitWidth: buttonContentRow.implicitWidth`, `implicitHeight: buttonContentRow.implicitHeight`) — the container with buttons (`PowerMenu.qml`) now correctly determines the size of its child elements;
- Buttons now stretch to the full width of the parent (they fill the available width of the `ColumnLayout`, adapting to the menu width);
- `popup-width` was removed from `default.conf`.

### Fixed files:
```bash
    components/
        Avatar.qml
        IconButton.qml
        PowerMenu.qml
```

---

```bash
    configs/
        default.conf
```
