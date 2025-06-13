<table><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="2" align="right"><a href="#general">[General]</a></td><td align="left">
<a href="#enableanimations">enable-animations</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#animatedbackgroundplaceholder">animated-background-placeholder</a>
</td>
<td align="center">string</td>
<td align="center"></td>
<td align="left">

File in `backgrounds/`

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="10" align="right"><a href="#lockscreen">[LockScreen]</a></td><td align="left">
<a href="#lockscreendisplay">display</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#lockscreenpaddingtop">padding-top</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockscreenpaddingright">padding-right</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockscreenpaddingbottom">padding-bottom</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockscreenpaddingleft">padding-left</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockscreenbackground">background</a>
</td>
<td align="center">string</td>
<td align="center">default.jpg</td>
<td align="left">

File in `backgrounds/`

</td></tr><tr><td align="left">
<a href="#lockscreenusebackgroundcolor">use-background-color</a>
</td>
<td align="center">bool</td>
<td align="center">false</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#lockscreenbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#000000</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#lockscreenblur">blur</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockscreenbrightness">brightness</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

-1.0 ≤ R ≤ 1.0

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="8" align="right"><a href="#lockscreenclock">[LockScreen.Clock]</a></td><td align="left">
<a href="#clockdisplay">display</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#clockposition">position</a>
</td>
<td align="center">string</td>
<td align="center">top-center</td>
<td align="left">

`top-left` `top-center` `top-right` `center-left` `center` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td></tr><tr><td align="left">
<a href="#clockalign">align</a>
</td>
<td align="center">string</td>
<td align="center">center</td>
<td align="left">

`left` `center` `right`

</td></tr><tr><td align="left">
<a href="#clockformat">format</a>
</td>
<td align="center">string</td>
<td align="center">hh:mm</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qtime.html#toString">QTime format string</a>

</td></tr><tr><td align="left">
<a href="#clockfontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#clockfontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">70</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#clockfontweight">font-weight</a>
</td>
<td align="center">int</td>
<td align="center">900</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#clockcolor">color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="7" align="right"><a href="#lockscreendate">[LockScreen.Date]</a></td><td align="left">
<a href="#datedisplay">display</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#dateformat">format</a>
</td>
<td align="center">string</td>
<td align="center">dddd, MMMM dd, yyyy</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qdate.html#toString">QDate format string</a>

</td></tr><tr><td align="left">
<a href="#datefontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#datefontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">14</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#datefontweight">font-weight</a>
</td>
<td align="center">int</td>
<td align="center">400</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#datecolor">color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#datemargintop">margin-top</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="11" align="right"><a href="#lockscreenmessage">[LockScreen.Message]</a></td><td align="left">
<a href="#lockmessagedisplay">display</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#lockmessageposition">position</a>
</td>
<td align="center">string</td>
<td align="center">bottom-center</td>
<td align="left">

`top-left` `top-center` `top-right` `center-left` `center` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td></tr><tr><td align="left">
<a href="#lockmessagealign">align</a>
</td>
<td align="center">string</td>
<td align="center">center</td>
<td align="left">

`left` `center` `right`

</td></tr><tr><td align="left">
<a href="#lockmessagetext">text</a>
</td>
<td align="center">string</td>
<td align="center">Press any key</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockmessagefontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockmessagefontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">12</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockmessagefontweight">font-weight</a>
</td>
<td align="center">int</td>
<td align="center">400</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockmessageicon">icon</a>
</td>
<td align="center">string</td>
<td align="center">enter.svg</td>
<td align="left">

File in `icons/`

</td></tr><tr><td align="left">
<a href="#lockmessageiconsize">icon-size</a>
</td>
<td align="center">int</td>
<td align="center">16</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#lockmessagecolor">color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#lockmessagespacing">spacing</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="5" align="right"><a href="#loginscreen">[LoginScreen]</a></td><td align="left">
<a href="#loginscreenbackground">background</a>
</td>
<td align="center">string</td>
<td align="center">default.jpg</td>
<td align="left">

File in `backgrounds/`

</td></tr><tr><td align="left">
<a href="#loginscreenusebackgroundcolor">use-background-color</a>
</td>
<td align="center">bool</td>
<td align="center">false</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#loginscreenbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#000000</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#loginscreenblur">blur</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#loginscreenbrightness">brightness</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

-1.0 ≤ R ≤ 1.0

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="3" align="right"><a href="#loginscreenloginarea">[LoginScreen.LoginArea]</a></td><td align="left">
<a href="#loginareaposition">position</a>
</td>
<td align="center">string</td>
<td align="center">center</td>
<td align="left">

`left` `center` `right`

</td></tr><tr><td align="left">
<a href="#loginareaalign">align</a>
</td>
<td align="center">string</td>
<td align="center">center</td>
<td align="left">

`left` `right`

</td></tr><tr><td align="left">
<a href="#loginareamargin">margin</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="9" align="right"><a href="#loginscreenloginareaavatar">[LoginScreen.LoginArea.Avatar]</a></td><td align="left">
<a href="#avatarshape">shape</a>
</td>
<td align="center">string</td>
<td align="center">circle</td>
<td align="left">

`circle` `square`

</td></tr><tr><td align="left">
<a href="#avatarborderradius">border-radius</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#avataractivesize">active-size</a>
</td>
<td align="center">int</td>
<td align="center">120</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#avatarinactivesize">inactive-size</a>
</td>
<td align="center">int</td>
<td align="center">80</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#avatarinactiveopacity">inactive-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.35</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#avataractivebordersize">active-border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#avatarinactivebordersize">inactive-border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#avataractivebordercolor">active-border-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#avatarinactivebordercolor">inactive-border-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="5" align="right"><a href="#loginscreenloginareausername">[LoginScreen.LoginArea.Username]</a></td><td align="left">
<a href="#usernamefontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#usernamefontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">16</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#usernamefontweight">font-weight</a>
</td>
<td align="center">int</td>
<td align="center">900</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#usernamecolor">color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#usernamemargin">margin</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="15" align="right"><a href="#loginscreenloginareapasswordinput">[LoginScreen.LoginArea.PasswordInput]</a></td><td align="left">
<a href="#passwordinputwidth">width</a>
</td>
<td align="center">int</td>
<td align="center">200</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#passwordinputheight">height</a>
</td>
<td align="center">int</td>
<td align="center">30</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#passwordinputdisplayicon">display-icon</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#passwordinputfontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#passwordinputfontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">12</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#passwordinputicon">icon</a>
</td>
<td align="center">string</td>
<td align="center">password.svg</td>
<td align="left">

File in `icons/`

</td></tr><tr><td align="left">
<a href="#passwordinputiconsize">icon-size</a>
</td>
<td align="center">int</td>
<td align="center">16</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#passwordinputcontentcolor">content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#passwordinputbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#passwordinputbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#passwordinputbordersize">border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#passwordinputbordercolor">border-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#passwordinputborderradiusleft">border-radius-left</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#passwordinputborderradiusright">border-radius-right</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#passwordinputmargintop">margin-top</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="18" align="right"><a href="#loginscreenloginarealoginbutton">[LoginScreen.LoginArea.LoginButton]</a></td><td align="left">
<a href="#loginbuttonbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#loginbuttonbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#loginbuttonactivebackgroundcolor">active-background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#loginbuttonactivebackgroundopacity">active-background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#loginbuttonicon">icon</a>
</td>
<td align="center">string</td>
<td align="center">arrow-right.svg</td>
<td align="left">

File in `icons/`

</td></tr><tr><td align="left">
<a href="#loginbuttoniconsize">icon-size</a>
</td>
<td align="center">int</td>
<td align="center">18</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#loginbuttoncontentcolor">content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#loginbuttonactivecontentcolor">active-content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#loginbuttonbordersize">border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#loginbuttonbordercolor">border-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#loginbuttonborderradiusleft">border-radius-left</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#loginbuttonborderradiusright">border-radius-right</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#loginbuttonmarginleft">margin-left</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#loginbuttonshowtextifnopassword">show-text-if-no-password</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#loginbuttonhideifnotneeded">hide-if-not-needed</a>
</td>
<td align="center">bool</td>
<td align="center">false</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#loginbuttonfontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#loginbuttonfontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">12</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#loginbuttonfontweight">font-weight</a>
</td>
<td align="center">int</td>
<td align="center">600</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="3" align="right"><a href="#loginscreenloginareaspinner">[LoginScreen.LoginArea.Spinner]</a></td><td align="left">
<a href="#spinnersize">size</a>
</td>
<td align="center">int</td>
<td align="center">32</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#spinnercolor">color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#spinnericon">icon</a>
</td>
<td align="center">string</td>
<td align="center">spinner.svg</td>
<td align="left">

File in `icons/`

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="7" align="right"><a href="#loginscreenloginareawarningmessage">[LoginScreen.LoginArea.WarningMessage]</a></td><td align="left">
<a href="#warningmessagefontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#warningmessagefontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">11</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#warningmessagefontweight">font-weight</a>
</td>
<td align="center">int</td>
<td align="center">400</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#warningmessagenormalcolor">normal-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#warningmessagewarningcolor">warning-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#warningmessageerrorcolor">error-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#warningmessagemargintop">margin-top</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="8" align="right"><a href="#loginscreenmenuareabuttons">[LoginScreen.MenuArea.Buttons]</a></td><td align="left">
<a href="#menuareabuttonsmargintop">margin-top</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareabuttonsmarginright">margin-right</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareabuttonsmarginbottom">margin-bottom</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareabuttonsmarginleft">margin-left</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareabuttonssize">size</a>
</td>
<td align="center">int</td>
<td align="center">30</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareabuttonsborderradius">border-radius</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareabuttonsspacing">spacing</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareabuttonsfontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="17" align="right"><a href="#loginscreenmenuareapopups">[LoginScreen.MenuArea.Popups]</a></td><td align="left">
<a href="#menuareapopupsmaxheight">max-height</a>
</td>
<td align="center">int</td>
<td align="center">300</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareapopupsitemheight">item-height</a>
</td>
<td align="center">int</td>
<td align="center">30</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareapopupsspacing">item-spacing</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareapopupspadding">padding</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareapopupsdisplayscrollbar">display-scrollbar</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#menuareapopupsmargin">margin</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareapopupsbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#menuareapopupsbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#menuareapopupsactiveoptionbackgroundcolor">active-option-background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#menuareapopupsactiveoptionbackgroundopacity">active-option-background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#menuareapopupscontentcolor">content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#menuareapopupsactivecontentcolor">active-content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#menuareapopupsfontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareapopupsbordersize">border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareapopupsbordercolor">border-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#menuareapopupsfontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">11</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#menuareapopupsiconsize">icon-size</a>
</td>
<td align="center">int</td>
<td align="center">16</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="15" align="right"><a href="#loginscreenmenuareasession">[LoginScreen.MenuArea.Session]</a></td><td align="left">
<a href="#sessiondisplay">display</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#sessionposition">position</a>
</td>
<td align="center">string</td>
<td align="center">bottom-left</td>
<td align="left">

`top-left` `top-center` `top-right` `center-left` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td></tr><tr><td align="left">
<a href="#sessionindex">index</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#sessionpopupdirection">popup-direction</a>
</td>
<td align="center">string</td>
<td align="center">up</td>
<td align="left">

`up` `down` `left` `right`

</td></tr><tr><td align="left">
<a href="#sessionpopupalign">popup-align</a>
</td>
<td align="center">string</td>
<td align="center">center</td>
<td align="left">

`start` `center` `end`

</td></tr><tr><td align="left">
<a href="#sessiondisplaysessionname">display-session-name</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#sessionmaxwidth">max-width</a>
</td>
<td align="center">int</td>
<td align="center">200</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#sessionbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#sessionbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#sessionactivebackgroundopacity">active-background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#sessioncontentcolor">content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#sessionactivecontentcolor">active-content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#sessionbordersize">border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#sessionfontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">10</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#sessioniconsize">icon-size</a>
</td>
<td align="center">int</td>
<td align="center">16</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="16" align="right"><a href="#loginscreenmenuarealayout">[LoginScreen.MenuArea.Layout]</a></td><td align="left">
<a href="#layoutdisplay">display</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#layoutposition">position</a>
</td>
<td align="center">string</td>
<td align="center">bottom-right</td>
<td align="left">

`top-left` `top-center` `top-right` `center-left` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td></tr><tr><td align="left">
<a href="#layoutindex">index</a>
</td>
<td align="center">int</td>
<td align="center">1</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#layoutpopupdirection">popup-direction</a>
</td>
<td align="center">string</td>
<td align="center">up</td>
<td align="left">

`up` `down` `left` `right`

</td></tr><tr><td align="left">
<a href="#layoutpopupalign">popup-align</a>
</td>
<td align="center">string</td>
<td align="center">center</td>
<td align="left">

`start` `center` `end`

</td></tr><tr><td align="left">
<a href="#layoutpopupwidth">popup-width</a>
</td>
<td align="center">int</td>
<td align="center">180</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#layoutdisplaylayoutname">display-layout-name</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#layoutbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#layoutbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#layoutactivebackgroundopacity">active-background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#layoutcontentcolor">content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#layoutactivecontentcolor">active-content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#layoutbordersize">border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#layoutfontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">10</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#layouticon">icon</a>
</td>
<td align="center">string</td>
<td align="center">language.svg</td>
<td align="left">

File in `icons/`

</td></tr><tr><td align="left">
<a href="#layouticonsize">icon-size</a>
</td>
<td align="center">int</td>
<td align="center">16</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="11" align="right"><a href="#loginscreenmenuareakeyboard">[LoginScreen.MenuArea.Keyboard]</a></td><td align="left">
<a href="#keyboarddisplay">display</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#keyboardposition">position</a>
</td>
<td align="center">string</td>
<td align="center">bottom-right</td>
<td align="left">

`top-left` `top-center` `top-right` `center-left` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td></tr><tr><td align="left">
<a href="#keyboardindex">index</a>
</td>
<td align="center">int</td>
<td align="center">2</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#keyboardbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#keyboardbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#keyboardactivebackgroundopacity">active-background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#keyboardcontentcolor">content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#keyboardactivecontentcolor">active-content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#keyboardbordersize">border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#keyboardicon">icon</a>
</td>
<td align="center">string</td>
<td align="center">keyboard.svg</td>
<td align="left">

File in `icons/`

</td></tr><tr><td align="left">
<a href="#keyboardiconsize">icon-size</a>
</td>
<td align="center">int</td>
<td align="center">16</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="14" align="right"><a href="#loginscreenmenuareapower">[LoginScreen.MenuArea.Power]</a></td><td align="left">
<a href="#powerdisplay">display</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#powerposition">position</a>
</td>
<td align="center">string</td>
<td align="center">bottom-right</td>
<td align="left">

`top-left` `top-center` `top-right` `center-left` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td></tr><tr><td align="left">
<a href="#powerindex">index</a>
</td>
<td align="center">int</td>
<td align="center">3</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#powerpopupdirection">popup-direction</a>
</td>
<td align="center">string</td>
<td align="center">up</td>
<td align="left">

`up` `down` `left` `right`

</td></tr><tr><td align="left">
<a href="#powerpopupalign">popup-align</a>
</td>
<td align="center">string</td>
<td align="center">center</td>
<td align="left">

`start` `center` `end`

</td></tr><tr><td align="left">
<a href="#powerpopupwidth">popup-width</a>
</td>
<td align="center">int</td>
<td align="center">90</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#powerbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#powerbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#poweractivebackgroundopacity">active-background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#powercontentcolor">content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#poweractivecontentcolor">active-content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#powerbordersize">border-size</a>
</td>
<td align="center">int</td>
<td align="center">0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#powericon">icon</a>
</td>
<td align="center">string</td>
<td align="center">power.svg</td>
<td align="left">

File in `icons/`

</td></tr><tr><td align="left">
<a href="#powericonsize">icon-size</a>
</td>
<td align="center">int</td>
<td align="center">16</td>
<td align="left">

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="14" align="right"><a href="#loginscreenvirtualkeyboard">[LoginScreen.VirtualKeyboard]</a></td><td align="left">
<a href="#virtualkeyboardscale">scale</a>
</td>
<td align="center">int</td>
<td align="center">1.0</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#virtualkeyboardposition">position</a>
</td>
<td align="center">string</td>
<td align="center">bottom</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#virtualkeyboardstarthidden">start-hidden</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#virtualkeyboardbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#virtualkeyboardbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#virtualkeyboardkeycontentcolor">key-content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#virtualkeyboardkeycolor">key-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#virtualkeyboardkeyopacity">key-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#virtualkeyboardkeyactivebackgroundcolor">key-active-background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#virtualkeyboardkeyactiveopacity">key-active-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#virtualkeyboardselectionbackgroundcolor">selection-background-color</a>
</td>
<td align="center">color</td>
<td align="center">#CCCCCC</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#virtualkeyboardselectioncontentcolor">selection-content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#virtualkeyboardprimarycolor">primary-color</a>
</td>
<td align="center">color</td>
<td align="center">#000000</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#virtualkeyboardaccentcolor">accent-color</a>
</td>
<td align="center">color</td>
<td align="center">#000000</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr><tr><td rowspan="9" align="right"><a href="#tooltips">[Tooltips]</a></td><td align="left">
<a href="#tooltipsenable">enable</a>
</td>
<td align="center">bool</td>
<td align="center">true</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#tooltipsfontfamily">font-family</a>
</td>
<td align="center">string</td>
<td align="center">RedHatDisplay</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#tooltipsfontsize">font-size</a>
</td>
<td align="center">int</td>
<td align="center">11</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#tooltipscontentcolor">content-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#tooltipsbackgroundcolor">background-color</a>
</td>
<td align="center">color</td>
<td align="center">#FFFFFF</td>
<td align="left">

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td></tr><tr><td align="left">
<a href="#tooltipsbackgroundopacity">background-opacity</a>
</td>
<td align="center">real</td>
<td align="center">0.0</td>
<td align="left">

0.0 ≤ R ≤ 1.0

</td></tr><tr><td align="left">
<a href="#tooltipsborderradius">border-radius</a>
</td>
<td align="center">int</td>
<td align="center">5</td>
<td align="left">

</td></tr><tr><td align="left">
<a href="#tooltipsdisableuser">disable-user</a>
</td>
<td align="center">bool</td>
<td align="center">false</td>
<td align="left">

`true` `false`

</td></tr><tr><td align="left">
<a href="#tooltipsdisableloginbutton">disable-login-button</a>
</td>
<td align="center">bool</td>
<td align="center">false</td>
<td align="left">

`true` `false`

</td></tr></table>

---

## [General]

<details name="enableanimations">
<summary><strong>enable-animations</strong></summary><br/>
<p>Enable or disable all animations.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="animatedbackgroundplaceholder">
<summary><strong>animated-background-placeholder</strong></summary><br/>
<p>An image file to be used as a placeholder for the animated background while it loads.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td></td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `backgrounds/`

</td>
</tr>
</table>
</details>

---

## [LockScreen]

<details name="lockscreendisplay">
<summary><strong>display</strong></summary><br/>
<p>Whether or not to display the lock screen. If false, the theme will load straight to the login screen.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="lockscreenpaddingtop">
<summary><strong>padding-top</strong></summary><br/>
<p>Top padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockscreenpaddingright">
<summary><strong>padding-right</strong></summary><br/>
<p>Right padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockscreenpaddingbottom">
<summary><strong>padding-bottom</strong></summary><br/>
<p>Bottom padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockscreenpaddingleft">
<summary><strong>padding-left</strong></summary><br/>
<p>Left padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockscreenbackground">
<summary><strong>background</strong></summary><br/>
<p>Background of the lock screen.<br/>Supported formats: jpg, png, gif, avi, mp4, mov, mkv, m4v, webm. <br/>See also: <a href="#animatedbackgroundplaceholder">animated-background-placeholder</a></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>default.jpg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `backgrounds/`

</td>
</tr>
</table>
</details>
<details name="lockscreenusebackgroundcolor">
<summary><strong>use-background-color</strong></summary><br/>
<p>Whether or not to use a plain color as background of the lock screen instead of an image/video file.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>false</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="lockscreenbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p>The color to be used as background of the lock screen. <br/>See also: <a href="#lockscreenusebackgroundcolor">use-background-color<a></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#000000</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="lockscreenblur">
<summary><strong>blur</strong></summary><br/>
<p>Amount of blur to be applied to the background of the lock screen. 0 means no blur.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockscreenbrightness">
<summary><strong>brightness</strong></summary><br/>
<p>Brightness of the background of the lock screen. 0.0 leaves unchanged, -1.0 makes it black and 1.0 white.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

-1.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>

---

## [LockScreen.Clock]

<details name="clockdisplay">
<summary><strong>display</strong></summary><br/>
<p>Whether or not to display the clock in the lock screen.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="clockposition">
<summary><strong>position</strong></summary><br/>
<p>Position of the clock and date in the lock screen. <br />See also: <a href="#lockscreenpaddingtop">LockScreen/padding-top</a></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>top-center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`top-left` `top-center` `top-right` `center-left` `center` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td>
</tr>
</table>
</details>
<details name="clockalign">
<summary><strong>align</strong></summary><br/>
<p>Relative alignment of the clock and date.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`left` `center` `right`

</td>
</tr>
</table>
</details>
<details name="clockformat">
<summary><strong>format</strong></summary><br/>
<p>Format string used for the clock.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>hh:mm</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qtime.html#toString">QTime format string</a>

</td>
</tr>
</table>
</details>
<details name="clockfontfamily">
<summary><strong>font-family</strong></summary><br/>
<p>Font family used for the clock.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="clockfontsize">
<summary><strong>font-size</strong></summary><br/>
<p>Font size of the clock.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>70</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="clockfontweight">
<summary><strong>font-weight</strong></summary><br/>
<p>Font weight of the clock. 400 = regular, 600 = bold, 800 = black</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>900</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="clockcolor">
<summary><strong>color</strong></summary><br/>
<p>Color of the clock.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>

---

## [LockScreen.Date]

<details name="datedisplay">
<summary><strong>display</strong></summary><br/>
<p>Whether or not to display the date in the lock screen.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="dateformat">
<summary><strong>format</strong></summary><br/>
<p>Format string used for the date.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>dddd, MMMM dd, yyyy</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qdate.html#toString">QDate format string</a>

</td>
</tr>
</table>
</details>
<details name="datefontfamily">
<summary><strong>font-family</strong></summary><br/>
<p>Font family used for the date.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="datefontsize">
<summary><strong>font-size</strong></summary><br/>
<p>Font size of the date.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>14</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="datefontweight">
<summary><strong>font-weight</strong></summary><br/>
<p>Font weight of the date. 400 = regular, 600 = bold, 800 = black</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>400</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="datecolor">
<summary><strong>color</strong></summary><br/>
<p>Color of the date.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="datemargintop">
<summary><strong>margin-top</strong></summary><br/>
<p>Top margin from the clock</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LockScreen.Message]

<details name="lockmessagedisplay">
<summary><strong>display</strong></summary><br/>
<p>Whether or not to display the custom message in the lock screen.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="lockmessageposition">
<summary><strong>position</strong></summary><br/>
<p>Position of the custom message in the lock screen. <br />See also: <a href="#lockscreenpaddingtop">LockScreen/padding-top</a></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>bottom-center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`top-left` `top-center` `top-right` `center-left` `center` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td>
</tr>
</table>
</details>
<details name="lockmessagealign">
<summary><strong>align</strong></summary><br/>
<p>Relative alignment of the custom message and its icon.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`left` `center` `right`

</td>
</tr>
</table>
</details>
<details name="lockmessagetext">
<summary><strong>text</strong></summary><br/>
<p>Text of the custom message.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>Press any key</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockmessagefontfamily">
<summary><strong>font-family</strong></summary><br/>
<p>Font family used for the custom message.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockmessagefontsize">
<summary><strong>font-size</strong></summary><br/>
<p>Font size of the custom message.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>12</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockmessagefontweight">
<summary><strong>font-weight</strong></summary><br/>
<p>Font weight of the date. 400 = regular, 600 = bold, 800 = black</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>400</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockmessageicon">
<summary><strong>icon</strong></summary><br/>
<p>Icon of the custom message.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>enter.svg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `icons/`

</td>
</tr>
</table>
</details>
<details name="lockmessageiconsize">
<summary><strong>icon-size</strong></summary><br/>
<p>Size of the custom message's icon.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>16</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="lockmessagecolor">
<summary><strong>color</strong></summary><br/>
<p>Color of the custom message. Apploes for both the icon and the text.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="lockmessagespacing">
<summary><strong>spacing</strong></summary><br/>
<p>Spacing between the icon and the text in the custom message.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen]

<details name="loginscreenbackground">
<summary><strong>background</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>default.jpg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `backgrounds/`

</td>
</tr>
</table>
</details>
<details name="loginscreenusebackgroundcolor">
<summary><strong>use-background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>false</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="loginscreenbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#000000</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="loginscreenblur">
<summary><strong>blur</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="loginscreenbrightness">
<summary><strong>brightness</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

-1.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>

---

## [LoginScreen.LoginArea]

<details name="loginareaposition">
<summary><strong>position</strong></summary><br/>
<p>Position of the login area.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`left` `center` `right`

</td>
</tr>
</table>
</details>
<details name="loginareaalign">
<summary><strong>align</strong></summary><br/>
<p>Alignment of the login area. Only applies if position is set to `left` or `right`.</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`left` `right`

</td>
</tr>
</table>
</details>
<details name="loginareamargin">
<summary><strong>margin</strong></summary><br/>
<p>Margin of the login area relative to its anchor point.<br/>If position is set to `center`, this option specifies the top margin, left/right margin otherwise.<br/><br/><strong>Set this option to `-1` to center the login area.</strong></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.LoginArea.Avatar]

<details name="avatarshape">
<summary><strong>shape</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>circle</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`circle` `square`

</td>
</tr>
</table>
</details>
<details name="avatarborderradius">
<summary><strong>border-radius</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="avataractivesize">
<summary><strong>active-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>120</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="avatarinactivesize">
<summary><strong>inactive-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>80</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="avatarinactiveopacity">
<summary><strong>inactive-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.35</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="avataractivebordersize">
<summary><strong>active-border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="avatarinactivebordersize">
<summary><strong>inactive-border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="avataractivebordercolor">
<summary><strong>active-border-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="avatarinactivebordercolor">
<summary><strong>inactive-border-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.LoginArea.Username]

<details name="usernamefontfamily">
<summary><strong>font-family</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="usernamefontsize">
<summary><strong>font-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>16</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="usernamefontweight">
<summary><strong>font-weight</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>900</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="usernamecolor">
<summary><strong>color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="usernamemargin">
<summary><strong>margin</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.LoginArea.PasswordInput]

<details name="passwordinputwidth">
<summary><strong>width</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>200</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="passwordinputheight">
<summary><strong>height</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>30</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="passwordinputdisplayicon">
<summary><strong>display-icon</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="passwordinputfontfamily">
<summary><strong>font-family</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="passwordinputfontsize">
<summary><strong>font-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>12</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="passwordinputicon">
<summary><strong>icon</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>password.svg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `icons/`

</td>
</tr>
</table>
</details>
<details name="passwordinputiconsize">
<summary><strong>icon-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>16</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="passwordinputcontentcolor">
<summary><strong>content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="passwordinputbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="passwordinputbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="passwordinputbordersize">
<summary><strong>border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="passwordinputbordercolor">
<summary><strong>border-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="passwordinputborderradiusleft">
<summary><strong>border-radius-left</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="passwordinputborderradiusright">
<summary><strong>border-radius-right</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="passwordinputmargintop">
<summary><strong>margin-top</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.LoginArea.LoginButton]

<details name="loginbuttonbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="loginbuttonbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="loginbuttonactivebackgroundcolor">
<summary><strong>active-background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="loginbuttonactivebackgroundopacity">
<summary><strong>active-background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="loginbuttonicon">
<summary><strong>icon</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>arrow-right.svg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `icons/`

</td>
</tr>
</table>
</details>
<details name="loginbuttoniconsize">
<summary><strong>icon-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>18</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="loginbuttoncontentcolor">
<summary><strong>content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="loginbuttonactivecontentcolor">
<summary><strong>active-content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="loginbuttonbordersize">
<summary><strong>border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="loginbuttonbordercolor">
<summary><strong>border-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="loginbuttonborderradiusleft">
<summary><strong>border-radius-left</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="loginbuttonborderradiusright">
<summary><strong>border-radius-right</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="loginbuttonmarginleft">
<summary><strong>margin-left</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="loginbuttonshowtextifnopassword">
<summary><strong>show-text-if-no-password</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="loginbuttonhideifnotneeded">
<summary><strong>hide-if-not-needed</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>false</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="loginbuttonfontfamily">
<summary><strong>font-family</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="loginbuttonfontsize">
<summary><strong>font-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>12</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="loginbuttonfontweight">
<summary><strong>font-weight</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>600</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.LoginArea.Spinner]

<details name="spinnersize">
<summary><strong>size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>32</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="spinnercolor">
<summary><strong>color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="spinnericon">
<summary><strong>icon</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>spinner.svg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `icons/`

</td>
</tr>
</table>
</details>

---

## [LoginScreen.LoginArea.WarningMessage]

<details name="warningmessagefontfamily">
<summary><strong>font-family</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="warningmessagefontsize">
<summary><strong>font-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>11</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="warningmessagefontweight">
<summary><strong>font-weight</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>400</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="warningmessagenormalcolor">
<summary><strong>normal-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="warningmessagewarningcolor">
<summary><strong>warning-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="warningmessageerrorcolor">
<summary><strong>error-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="warningmessagemargintop">
<summary><strong>margin-top</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.MenuArea.Buttons]

<details name="menuareabuttonsmargintop">
<summary><strong>margin-top</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareabuttonsmarginright">
<summary><strong>margin-right</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareabuttonsmarginbottom">
<summary><strong>margin-bottom</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareabuttonsmarginleft">
<summary><strong>margin-left</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareabuttonssize">
<summary><strong>size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>30</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareabuttonsborderradius">
<summary><strong>border-radius</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareabuttonsspacing">
<summary><strong>spacing</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareabuttonsfontfamily">
<summary><strong>font-family</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.MenuArea.Popups]

<details name="menuareapopupsmaxheight">
<summary><strong>max-height</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>300</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsitemheight">
<summary><strong>item-height</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>30</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsspacing">
<summary><strong>item-spacing</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareapopupspadding">
<summary><strong>padding</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsdisplayscrollbar">
<summary><strong>display-scrollbar</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="menuareapopupsmargin">
<summary><strong>margin</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="menuareapopupsactiveoptionbackgroundcolor">
<summary><strong>active-option-background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsactiveoptionbackgroundopacity">
<summary><strong>active-option-background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="menuareapopupscontentcolor">
<summary><strong>content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsactivecontentcolor">
<summary><strong>active-content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsfontfamily">
<summary><strong>font-family</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsbordersize">
<summary><strong>border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsbordercolor">
<summary><strong>border-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsfontsize">
<summary><strong>font-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>11</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="menuareapopupsiconsize">
<summary><strong>icon-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>16</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.MenuArea.Session]

<details name="sessiondisplay">
<summary><strong>display</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="sessionposition">
<summary><strong>position</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>bottom-left</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`top-left` `top-center` `top-right` `center-left` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td>
</tr>
</table>
</details>
<details name="sessionindex">
<summary><strong>index</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="sessionpopupdirection">
<summary><strong>popup-direction</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>up</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`up` `down` `left` `right`

</td>
</tr>
</table>
</details>
<details name="sessionpopupalign">
<summary><strong>popup-align</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`start` `center` `end`

</td>
</tr>
</table>
</details>
<details name="sessiondisplaysessionname">
<summary><strong>display-session-name</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="sessionmaxwidth">
<summary><strong>max-width</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>200</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="sessionbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="sessionbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="sessionactivebackgroundopacity">
<summary><strong>active-background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="sessioncontentcolor">
<summary><strong>content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="sessionactivecontentcolor">
<summary><strong>active-content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="sessionbordersize">
<summary><strong>border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="sessionfontsize">
<summary><strong>font-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>10</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="sessioniconsize">
<summary><strong>icon-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>16</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.MenuArea.Layout]

<details name="layoutdisplay">
<summary><strong>display</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="layoutposition">
<summary><strong>position</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>bottom-right</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`top-left` `top-center` `top-right` `center-left` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td>
</tr>
</table>
</details>
<details name="layoutindex">
<summary><strong>index</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>1</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="layoutpopupdirection">
<summary><strong>popup-direction</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>up</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`up` `down` `left` `right`

</td>
</tr>
</table>
</details>
<details name="layoutpopupalign">
<summary><strong>popup-align</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`start` `center` `end`

</td>
</tr>
</table>
</details>
<details name="layoutpopupwidth">
<summary><strong>popup-width</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>180</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="layoutdisplaylayoutname">
<summary><strong>display-layout-name</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="layoutbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="layoutbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="layoutactivebackgroundopacity">
<summary><strong>active-background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="layoutcontentcolor">
<summary><strong>content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="layoutactivecontentcolor">
<summary><strong>active-content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="layoutbordersize">
<summary><strong>border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="layoutfontsize">
<summary><strong>font-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>10</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="layouticon">
<summary><strong>icon</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>language.svg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `icons/`

</td>
</tr>
</table>
</details>
<details name="layouticonsize">
<summary><strong>icon-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>16</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.MenuArea.Keyboard]

<details name="keyboarddisplay">
<summary><strong>display</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="keyboardposition">
<summary><strong>position</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>bottom-right</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`top-left` `top-center` `top-right` `center-left` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td>
</tr>
</table>
</details>
<details name="keyboardindex">
<summary><strong>index</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>2</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="keyboardbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="keyboardbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="keyboardactivebackgroundopacity">
<summary><strong>active-background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="keyboardcontentcolor">
<summary><strong>content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="keyboardactivecontentcolor">
<summary><strong>active-content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="keyboardbordersize">
<summary><strong>border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="keyboardicon">
<summary><strong>icon</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>keyboard.svg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `icons/`

</td>
</tr>
</table>
</details>
<details name="keyboardiconsize">
<summary><strong>icon-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>16</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.MenuArea.Power]

<details name="powerdisplay">
<summary><strong>display</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="powerposition">
<summary><strong>position</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>bottom-right</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`top-left` `top-center` `top-right` `center-left` `center-right` `bottom-left` `bottom-center` `bottom-right`

</td>
</tr>
</table>
</details>
<details name="powerindex">
<summary><strong>index</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>3</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="powerpopupdirection">
<summary><strong>popup-direction</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>up</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`up` `down` `left` `right`

</td>
</tr>
</table>
</details>
<details name="powerpopupalign">
<summary><strong>popup-align</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>center</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`start` `center` `end`

</td>
</tr>
</table>
</details>
<details name="powerpopupwidth">
<summary><strong>popup-width</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>90</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="powerbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="powerbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="poweractivebackgroundopacity">
<summary><strong>active-background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="powercontentcolor">
<summary><strong>content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="poweractivecontentcolor">
<summary><strong>active-content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="powerbordersize">
<summary><strong>border-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="powericon">
<summary><strong>icon</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>power.svg</td>
</tr>
<tr>
<td>Possible values</td>
<td>

File in `icons/`

</td>
</tr>
</table>
</details>
<details name="powericonsize">
<summary><strong>icon-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>16</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>

---

## [LoginScreen.VirtualKeyboard]

<details name="virtualkeyboardscale">
<summary><strong>scale</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>1.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardposition">
<summary><strong>position</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>bottom</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardstarthidden">
<summary><strong>start-hidden</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardkeycontentcolor">
<summary><strong>key-content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardkeycolor">
<summary><strong>key-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardkeyopacity">
<summary><strong>key-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardkeyactivebackgroundcolor">
<summary><strong>key-active-background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardkeyactiveopacity">
<summary><strong>key-active-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardselectionbackgroundcolor">
<summary><strong>selection-background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#CCCCCC</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardselectioncontentcolor">
<summary><strong>selection-content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardprimarycolor">
<summary><strong>primary-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#000000</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="virtualkeyboardaccentcolor">
<summary><strong>accent-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#000000</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>

---

## [Tooltips]

<details name="tooltipsenable">
<summary><strong>enable</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>true</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="tooltipsfontfamily">
<summary><strong>font-family</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>string</td>
</tr>
<tr>
<td>Default value</td>
<td>RedHatDisplay</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="tooltipsfontsize">
<summary><strong>font-size</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>11</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="tooltipscontentcolor">
<summary><strong>content-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="tooltipsbackgroundcolor">
<summary><strong>background-color</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>color</td>
</tr>
<tr>
<td>Default value</td>
<td>#FFFFFF</td>
</tr>
<tr>
<td>Possible values</td>
<td>

<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>

</td>
</tr>
</table>
</details>
<details name="tooltipsbackgroundopacity">
<summary><strong>background-opacity</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>real</td>
</tr>
<tr>
<td>Default value</td>
<td>0.0</td>
</tr>
<tr>
<td>Possible values</td>
<td>

0.0 ≤ R ≤ 1.0

</td>
</tr>
</table>
</details>
<details name="tooltipsborderradius">
<summary><strong>border-radius</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>int</td>
</tr>
<tr>
<td>Default value</td>
<td>5</td>
</tr>
<tr>
<td>Possible values</td>
<td>

</td>
</tr>
</table>
</details>
<details name="tooltipsdisableuser">
<summary><strong>disable-user</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>false</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>
<details name="tooltipsdisableloginbutton">
<summary><strong>disable-login-button</strong></summary><br/>
<p></p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>bool</td>
</tr>
<tr>
<td>Default value</td>
<td>false</td>
</tr>
<tr>
<td>Possible values</td>
<td>

`true` `false`

</td>
</tr>
</table>
</details>

---
