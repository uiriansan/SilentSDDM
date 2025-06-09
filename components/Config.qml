pragma Singleton

import QtQuick

/*
    `config["option"]` is used in some places instead of `config.boolValue("option")` so we can default to `true`.
    https://github.com/sddm/sddm/wiki/Theming#new-explicitly-typed-api-since-sddm-020
*/
QtObject {
    // [General]
    property bool enableAnimations: config['enable-animations'] === "false" ? false : true // @desc:Enable or disable all animations.
    property string animatedBackgroundPlaceholder: config.stringValue("animated-background-placeholder") // @possible:File in `backgrounds/` @desc:An image file to be used as a placeholder for the animated background while it loads.

    // [LockScreen]
    property bool lockScreenDisplay: config['LockScreen/display'] === "false" ? false : true // @desc:Whether or not to display the lock screen. If false, the theme will load straight to the login screen.
    property int lockScreenPaddingTop: config.intValue("LockScreen/padding-top") // @desc:Top padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.
    property int lockScreenPaddingRight: config.intValue("LockScreen/padding-right") // @desc:Right padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.
    property int lockScreenPaddingBottom: config.intValue("LockScreen/padding-bottom") // @desc:Bottom padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.
    property int lockScreenPaddingLeft: config.intValue("LockScreen/padding-left") // @desc:Left padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.
    property string lockScreenBackground: config.stringValue("LockScreen/background") || "default.jpg" // @possible:File in `backgrounds/` @desc:Background of the lock screen.<br/>Supported formats: jpg, png, gif, avi, mp4, mov, mkv, m4v, webm. <br/>See also: <a href="#animatedbackgroundplaceholder">animated-background-placeholder</a>
    property bool lockScreenUseBackgroundColor: config.boolValue('LockScreen/use-background-color') // @desc:Whether or not to use a plain color as background of the lock screen instead of an image/video file.
    property color lockScreenBackgroundColor: config.stringValue("LockScreen/background-color") || "#000000" // @desc:The color to be used as background of the lock screen. <br/>See also: <a href="#lockscreenusebackgroundcolor">use-background-color<a>
    property int lockScreenBlur: config.intValue("LockScreen/blur") // @desc:Amount of blur to be applied to the background of the lock screen. 0 means no blur.
    property real lockScreenBrightness: config.realValue("LockScreen/brightness") // @possible:-1.0 ≤ R ≤ 1.0 @desc:Brightness of the background of the lock screen. 0.0 leaves unchanged, -1.0 makes it black and 1.0 white.

    // [LockScreen.Clock]
    property bool clockDisplay: config['LockScreen.Clock/display'] === "false" ? false : true // @desc:Whether or not to display the clock in the lock screen.
    property string clockPosition: config.stringValue("LockScreen.Clock/position") || "top-center" // @possible:'top-left' | 'top-center' | 'top-right' | 'center-left' | 'center' | 'center-right' | 'bottom-left' | 'bottom-center' | 'bottom-right' @desc:Position of the clock and date in the lock screen. <br />See also: <a href="#lockscreenpaddingtop">LockScreen/padding-top</a>
    property string clockAlign: config.stringValue("LockScreen.Clock/align") || "center" // @possible:'left' | 'center' | 'right' @desc:Relative alignment of the clock and date.
    property string clockFormat: config.stringValue("LockScreen.Clock/format") || "hh:mm" // @desc:Format string used for the clock.
    property string clockFontFamily: config.stringValue("LockScreen.Clock/font-family") || "RedHatDisplay" // @desc:Font family used for the clock.
    property int clockFontSize: config.intValue("LockScreen.Clock/font-size") || 70 // @desc:Font size of the clock.
    property int clockFontWeight: config.intValue("LockScreen.Clock/font-weight") || 900 // @desc:Font weight of the clock. 400 = regular, 600 = bold, 800 = black
    property color clockColor: config.stringValue("LockScreen.Clock/color") || "#FFFFFF" // @desc:Color of the clock.

    // [LockScreen.Date]
    property bool dateDisplay: config['LockScreen.Date/display'] === "false" ? false : true // @desc:Whether or not to display the date in the lock screen.
    property string dateFormat: config.stringValue("LockScreen.Date/format") || "dddd, MMMM dd, yyyy" // @desc:Format string used for the date.
    property string dateFontFamily: config.stringValue("LockScreen.Date/font-family") || "RedHatDisplay" // @desc:Font family used for the date.
    property int dateFontSize: config.intValue("LockScreen.Date/font-size") || 14 // @desc:Font size of the date.
    property int dateFontWeight: config.intValue("LockScreen.Date/font-weight") || 400 // @desc:Font weight of the date. 400 = regular, 600 = bold, 800 = black
    property color dateColor: config.stringValue("LockScreen.Date/color") || "#FFFFFF" // @desc:Color of the date.
    property int dateMarginTop: config.intValue("LockScreen.Date/margin-top") // @desc:Top margin from the clock

    // [LockScreen.Message]
    property bool lockMessageDisplay: config['LockScreen.Message/display'] === "false" ? false : true // @desc:Whether or not to display the custom message in the lock screen.
    property string lockMessagePosition: config.stringValue("LockScreen.Message/position") || "bottom-center" // @possible:'top-left' | 'top-center' | 'top-right' | 'center-left' | 'center' | 'center-right' | 'bottom-left' | 'bottom-center' | 'bottom-right' @desc:Position of the custom message in the lock screen. <br />See also: <a href="#lockscreenpaddingtop">LockScreen/padding-top</a>
    property string lockMessageAlign: config.stringValue("LockScreen.Message/align") || "center" // @possible:'left' | 'center' | 'right' @desc:Relative alignment of the custom message and its icon.
    property string lockMessageText: config.stringValue("LockScreen.Message/text") || "Press any key" // @desc:Text of the custom message.
    property string lockMessageFontFamily: config.stringValue("LockScreen.Message/font-family") || "RedHatDisplay" // @desc:Font family used for the custom message.
    property int lockMessageFontSize: config.intValue("LockScreen.Message/font-size") || 12 // @desc:Font size of the custom message.
    property int lockMessageFontWeight: config.intValue("LockScreen.Message/font-weight") || 400 // @desc:Font weight of the date. 400 = regular, 600 = bold, 800 = black
    property string lockMessageIcon: config.stringValue("LockScreen.Message/icon") || "enter.svg" // @possible:File in `icons/` @desc:Icon of the custom message.
    property int lockMessageIconSize: config.intValue("LockScreen.Message/icon-size") || 16 // @desc:Size of the custom message's icon.
    property color lockMessageColor: config.stringValue("LockScreen.Message/color") || "#FFFFFF" // @desc:Color of the custom message. Apploes for both the icon and the text.
    property int lockMessageSpacing: config.intValue("LockScreen.Message/spacing") // @desc:Spacing between the icon and the text in the custom message.

    // [LoginScreen] *
    property int loginScreenPaddingTop: config.intValue("LoginScreen/padding-top")
    property int loginScreenPaddingRight: config.intValue("LoginScreen/padding-right")
    property int loginScreenPaddingBottom: config.intValue("LoginScreen/padding-bottom")
    property int loginScreenPaddingLeft: config.intValue("LoginScreen/padding-left")
    property string loginScreenBackground: config.stringValue("LoginScreen/background") || "default.jpg" // @possible:File in `backgrounds/`
    property bool loginScreenUseBackgroundColor: config.boolValue('LoginScreen/use-background-color')
    property color loginScreenBackgroundColor: config.stringValue("LoginScreen/background-color") || "#000000"
    property int loginScreenBlur: config.intValue("LoginScreen/blur")
    property real loginScreenBrightness: config.realValue("LoginScreen/brightness") // @possible:-1.0 ≤ R ≤ 1.0

    // [LoginScreen.LoginArea] *
    property string loginAreaPosition: config.stringValue("LoginScreen.LoginArea/position") || "center" // @possible:'left' | 'center' | 'right'
    property string loginAreaAlign: config.stringValue("LoginScreen.LoginArea/align") || "center" // @possible:'left' | 'right'

    // [LoginScreen.LoginArea.Avatar]
    property string avatarShape: config.stringValue("LoginScreen.LoginArea.Avatar/shape") || "circle" // @possible:'circle' || 'square'
    property int avatarBorderRadius: config.intValue("LoginScreen.LoginArea.Avatar/border-radius")
    property int avatarActiveSize: config.intValue("LoginScreen.LoginArea.Avatar/active-size") || 120
    property int avatarInactiveSize: config.intValue("LoginScreen.LoginArea.Avatar/inactive-size") || 80
    property real avatarInactiveOpacity: config.realValue("LoginScreen.LoginArea.Avatar/inactive-opacity") || 0.35
    property int avatarActiveBorderSize: config.intValue("LoginScreen.LoginArea.Avatar/active-border-size")
    property int avatarInactiveBorderSize: config.intValue("LoginScreen.LoginArea.Avatar/inactive-border-size")
    property color avatarActiveBorderColor: config.stringValue("LoginScreen.LoginArea.Avatar/active-border-color") || "#FFFFFF"
    property color avatarInactiveBorderColor: config.stringValue("LoginScreen.LoginArea.Avatar/inactive-border-color") || "#FFFFFF"

    // [LoginScreen.LoginArea.Username]
    property string usernameFontFamily: config.stringValue("LoginScreen.LoginArea.Username/font-family") || "RedHatDisplay"
    property int usernameFontSize: config.intValue("LoginScreen.LoginArea.Username/font-size") || 16
    property int usernameFontWeight: config.intValue("LoginScreen.LoginArea.Username/font-weight") || 900
    property color usernameColor: config.stringValue("LoginScreen.LoginArea.Username/color") || "#FFFFFF"
    property int usernameMarginTop: config.intValue("LoginScreen.LoginArea.Username/margin-top")

    // [LoginScreen.LoginArea.PasswordInput]
    property int passwordInputWidth: config.intValue("LoginScreen.LoginArea.PasswordInput/width") || 200
    property int passwordInputHeight: config.intValue("LoginScreen.LoginArea.PasswordInput/height") || 30
    property bool passwordInputDisplayIcon: config['LoginScreen.LoginArea.PasswordInput/display-icon'] === "false" ? false : true
    property string passwordInputFontFamily: config.stringValue("LoginScreen.LoginArea.PasswordInput/font-family") || "RedHatDisplay"
    property int passwordInputFontSize: config.intValue("LoginScreen.LoginArea.PasswordInput/font-size") || 12
    property string passwordInputIcon: config.stringValue("LoginScreen.LoginArea.PasswordInput/icon") || "password.svg" // @possible:File in `icons/`
    property int passwordInputIconSize: config.intValue("LoginScreen.LoginArea.PasswordInput/icon-size") || 16
    property color passwordInputContentColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/content-color") || "#FFFFFF"
    property color passwordInputBackgroundColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/background-color") || "#FFFFFF"
    property real passwordInputBackgroundOpacity: config.realValue("LoginScreen.LoginArea.PasswordInput/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property int passwordInputBorderSize: config.intValue("LoginScreen.LoginArea.PasswordInput/border-size")
    property color passwordInputBorderColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/border-color") || "#FFFFFF"
    property int passwordInputBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-left")
    property int passwordInputBorderRadiusRight: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-right")
    property int passwordInputMarginTop: config.intValue("LoginScreen.LoginArea.PasswordInput/margin-top")

    // [LoginScreen.LoginArea.LoginButton]
    property color loginButtonBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/background-color") || "#FFFFFF"
    property real loginButtonBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color loginButtonActiveBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-background-color") || "#FFFFFF"
    property real loginButtonActiveBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property string loginButtonIcon: config.stringValue("LoginScreen.LoginArea.LoginButton/icon") || "arrow-right.svg" // @possible:File in `icons/`
    property int loginButtonIconSize: config.intValue("LoginScreen.LoginArea.LoginButton/icon-size") || 18
    property color loginButtonContentColor: config.stringValue("LoginScreen.LoginArea.LoginButton/content-color") || "#FFFFFF"
    property color loginButtonActiveContentColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-content-color") || "#FFFFFF"
    property int loginButtonBorderSize: config.intValue("LoginScreen.LoginArea.LoginButton/border-size")
    property color loginButtonBorderColor: config.stringValue("LoginScreen.LoginArea.LoginButton/border-color") || "#FFFFFF"
    property int loginButtonBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.LoginButton/border-radius-left")
    property int loginButtonBorderRadiusRight: config.intValue("LoginScreen.LoginArea.LoginButton/border-radius-right")
    property int loginButtonMarginLeft: config.intValue("LoginScreen.LoginArea.LoginButton/margin-left")
    property bool loginButtonShowTextIfNoPassword: config['LoginScreen.LoginArea.LoginButton/show-text-if-no-password'] === "false" ? false : true
    property bool loginButtonHideIfNotNeeded: config.boolValue("LoginScreen.LoginArea.LoginButton/hide-if-not-needed")
    property string loginButtonFontFamily: config.stringValue("LoginScreen.LoginArea.LoginButton/font-family") || "RedHatDisplay"
    property int loginButtonFontSize: config.intValue("LoginScreen.LoginArea.LoginButton/font-size") || 12
    property int loginButtonFontWeight: config.intValue("LoginScreen.LoginArea.LoginButton/font-weight") || 600

    // [LoginScreen.LoginArea.Spinner]
    property int spinnerSize: config.intValue("LoginScreen.LoginArea.Spinner/size") || 32
    property color spinnerColor: config.stringValue("LoginScreen.LoginArea.Spinner/color") || "#FFFFFF"
    property string spinnerIcon: config.stringValue("LoginScreen.LoginArea.Spinner/icon") || "spinner.svg" // @possible:File in `icons/`

    // [LoginScreen.LoginArea.WarningMessage]
    property string warningMessageFontFamily: config.stringValue("LoginScreen.LoginArea.WarningMessage/font-family") || "RedHatDisplay"
    property int warningMessageFontSize: config.intValue("LoginScreen.LoginArea.WarningMessage/font-size") || 11
    property int warningMessageFontWeight: config.intValue("LoginScreen.LoginArea.WarningMessage/font-weight") || 400
    property color warningMessageNormalColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/normal-color") || "#FFFFFF"
    property color warningMessageWarningColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/warning-color") || "#FFFFFF"
    property color warningMessageErrorColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/error-color") || "#FFFFFF"
    property int warningMessageMarginTop: config.intValue("LoginScreen.LoginArea.WarningMessage/margin-top")

    // [LoginScreen.MenuArea.Buttons]
    property int menuAreaButtonsSize: config.intValue("LoginScreen.MenuArea.Buttons/size") || 30
    property int menuAreaButtonsBorderRadius: config.intValue("LoginScreen.MenuArea.Buttons/border-radius")
    property int menuAreaButtonsSpacing: config.intValue("LoginScreen.MenuArea.Buttons/spacing")
    property string menuAreaButtonsFontFamily: config.stringValue("LoginScreen.MenuArea.Buttons/font-family") || "RedHatDisplay"

    // [LoginScreen.MenuArea.Popups]
    property int menuAreaPopupsMaxHeight: config.intValue("LoginScreen.MenuArea.Popups/max-height") || 300
    property int menuAreaPopupsItemHeight: config.intValue("LoginScreen.MenuArea.Popups/item-height") || 30
    property int menuAreaPopupsSpacing: config.intValue("LoginScreen.MenuArea.Popups/item-spacing")
    property int menuAreaPopupsPadding: config.intValue("LoginScreen.MenuArea.Popups/padding")
    property int menuAreaPopupsMargin: config.intValue("LoginScreen.MenuArea.Popups/margin")
    property color menuAreaPopupsBackgroundColor: config.stringValue("LoginScreen.MenuArea.Popups/background-color") || "#FFFFFF"
    property real menuAreaPopupsBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Popups/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color menuAreaPopupsActiveOptionBackgroundColor: config.stringValue("LoginScreen.MenuArea.Popups/active-option-background-color") || "#FFFFFF"
    property real menuAreaPopupsActiveOptionBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Popups/active-option-background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color menuAreaPopupsContentColor: config.stringValue("LoginScreen.MenuArea.Popups/content-color") || "#FFFFFF"
    property color menuAreaPopupsActiveContentColor: config.stringValue("LoginScreen.MenuArea.Popups/active-content-color") || "#FFFFFF"
    property string menuAreaPopupsFontFamily: config.stringValue("LoginScreen.MenuArea.Popups/font-family") || "RedHatDisplay"
    property int menuAreaPopupsFontSize: config.intValue("LoginScreen.MenuArea.Popups/font-size") || 11
    property int menuAreaPopupsIconSize: config.intValue("LoginScreen.MenuArea.Popups/icon-size") || 16

    // [LoginScreen.MenuArea.Session]
    property string sessionPopupDirection: config.stringValue("LoginScreen.MenuArea.Session/popup-direction") || "up" // @possible:'up' | 'down' | 'left' | 'right'
    property bool sessionDisplaySessionName: config['LoginScreen.MenuArea.Session/display-session-name'] === "false" ? false : true
    property int sessionMaxWidth: config.intValue("LoginScreen.MenuArea.Session/max-width") || 200
    property color sessionBackgroundColor: config.stringValue("LoginScreen.MenuArea.Session/background-color") || "#FFFFFF"
    property real sessionBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property real sessionActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color sessionContentColor: config.stringValue("LoginScreen.MenuArea.Session/content-color") || "#FFFFFF"
    property color sessionActiveContentColor: config.stringValue("LoginScreen.MenuArea.Session/active-content-color") || "#FFFFFF"
    property int sessionBorderSize: config.intValue("LoginScreen.MenuArea.Session/border-size")
    property int sessionFontSize: config.intValue("LoginScreen.MenuArea.Session/font-size") || 10
    property int sessionIconSize: config.intValue("LoginScreen.MenuArea.Session/icon-size") || 16

    // [LoginScreen.MenuArea.Layout]
    property string layoutPopupDirection: config.stringValue("LoginScreen.MenuArea.Layout/popup-direction") || "up" // @possible:'up' | 'down' | 'left' | 'right'
    property int layoutPopupWidth: config.intValue("LoginScreen.MenuArea.Layout/popup-width") || 180
    property bool layoutDisplayLayoutName: config['LoginScreen.MenuArea.Layout/display-layout-name'] === "false" ? false : true
    property color layoutBackgroundColor: config.stringValue("LoginScreen.MenuArea.Layout/background-color") || "#FFFFFF"
    property real layoutBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Layout/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property real layoutActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Layout/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color layoutContentColor: config.stringValue("LoginScreen.MenuArea.Layout/content-color") || "#FFFFFF"
    property color layoutActiveContentColor: config.stringValue("LoginScreen.MenuArea.Layout/active-content-color") || "#FFFFFF"
    property int layoutBorderSize: config.intValue("LoginScreen.MenuArea.Layout/border-size")
    property int layoutFontSize: config.intValue("LoginScreen.MenuArea.Layout/font-size") || 10
    property string layoutIcon: config.stringValue("LoginScreen.MenuArea.Layout/icon") || "language.svg" // @possible:File in `icons/`
    property int layoutIconSize: config.intValue("LoginScreen.MenuArea.Layout/icon-size") || 16

    // [LoginScreen.MenuArea.Keyboard]
    property color keyboardBackgroundColor: config.stringValue("LoginScreen.MenuArea.Keyboard/background-color") || "#FFFFFF"
    property real keyboardBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Keyboard/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property real keyboardActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Keyboard/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color keyboardContentColor: config.stringValue("LoginScreen.MenuArea.Keyboard/content-color") || "#FFFFFF"
    property color keyboardActiveContentColor: config.stringValue("LoginScreen.MenuArea.Keyboard/active-content-color") || "#FFFFFF"
    property int keyboardBorderSize: config.intValue("LoginScreen.MenuArea.Keyboard/border-size")
    property string keyboardIcon: config.stringValue("LoginScreen.MenuArea.Keyboard/icon") || "keyboard.svg" // @possible:File in `icons/`
    property int keyboardIconSize: config.intValue("LoginScreen.MenuArea.Keyboard/icon-size") || 16

    // [LoginScreen.MenuArea.Power]
    property string powerPopupDirection: config.stringValue("LoginScreen.MenuArea.Power/popup-direction") || "up" // @possible:'up' | 'down' | 'left' | 'right'
    property int powerPopupWidth: config.intValue("LoginScreen.MenuArea.Power/popup-width") || 90
    property color powerBackgroundColor: config.stringValue("LoginScreen.MenuArea.Power/background-color") || "#FFFFFF"
    property real powerBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Power/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property real powerActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Power/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color powerContentColor: config.stringValue("LoginScreen.MenuArea.Power/content-color") || "#FFFFFF"
    property color powerActiveContentColor: config.stringValue("LoginScreen.MenuArea.Power/active-content-color") || "#FFFFFF"
    property int powerBorderSize: config.intValue("LoginScreen.MenuArea.Power/border-size")
    property string powerIcon: config.stringValue("LoginScreen.MenuArea.Power/icon") || "power.svg" // @possible:File in `icons/`
    property int powerIconSize: config.intValue("LoginScreen.MenuArea.Power/icon-size") || 16

    // [LoginScreen.VirtualKeyboard]
    property int virtualKeyboardScale: config.realValue("LoginScreen.VirtualKeyboard/scale") || 1.0
    property string virtualKeyboardPosition: config.stringValue("LoginScreen.VirtualKeyboard/position") || "bottom"
    property bool virtualKeyboardStartHidden: config['LoginScreen.VirtualKeyboard/start-hidden'] === "false" ? false : true
    property color virtualKeyboardBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/background-color") || "#FFFFFF"
    property real virtualKeyboardBackgroundOpacity: config.realValue("LoginScreen.VirtualKeyboard/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color virtualKeyboardKeyContentColor: config.stringValue("LoginScreen.VirtualKeyboard/key-content-color") || "#FFFFFF"
    property color virtualKeyboardKeyColor: config.stringValue("LoginScreen.VirtualKeyboard/key-color") || "#FFFFFF"
    property real virtualKeyboardKeyOpacity: config.realValue("LoginScreen.VirtualKeyboard/key-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color virtualKeyboardKeyActiveBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/key-active-background-color") || "#FFFFFF"
    property real virtualKeyboardKeyActiveOpacity: config.realValue("LoginScreen.VirtualKeyboard/key-active-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property color virtualKeyboardSelectionBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/selection-background-color") || "#CCCCCC"
    property color virtualKeyboardSelectionContentColor: config.stringValue("LoginScreen.VirtualKeyboard/selection-content-color") || "#FFFFFF"
    property color virtualKeyboardPrimaryColor: config.stringValue("LoginScreen.VirtualKeyboard/primary-color") || "#000000"
    property color virtualKeyboardAccentColor: config.stringValue("LoginScreen.VirtualKeyboard/accent-color") || "#000000"

    // [Tooltips]
    property bool tooltipsEnable: config['Tooltips/enable'] === "false" ? false : true
    property string tooltipsFontFamily: config.stringValue("Tooltips/font-family") || "RedHatDisplay"
    property int tooltipsFontSize: config.intValue("Tooltips/font-size") || 11
    property color tooltipsContentColor: config.stringValue("Tooltips/content-color") || "#FFFFFF"
    property color tooltipsBackgroundColor: config.stringValue("Tooltips/background-color") || "#FFFFFF"
    property real tooltipsBackgroundOpacity: config.realValue("Tooltips/background-opacity") // @possible:0.0 ≤ R ≤ 1.0
    property int tooltipsBorderRadius: config.intValue("Tooltips/border-radius") || 5
    property bool tooltipsDisableUser: config.boolValue("Tooltips/disable-user")
    property bool tooltipsDisableLoginButton: config.boolValue("Tooltips/disable-login-button")

    function sortMenuButtons() {
        // LoginScreen.MenuArea.Session
        const sessionButtonDisplay = config["LoginScreen.MenuArea.Session/display"] === "false" ? false : true;
        const sessionButtonPosition = config.stringValue("LoginScreen.MenuArea.Session/position");
        const sessionButtonIndex = config.intValue("LoginScreen.MenuArea.Session/index");

        // LoginScreen.MenuArea.Keyboard
        const keyboardButtonDisplay = config["LoginScreen.MenuArea.Keyboard/display"] === "false" ? false : true;
        const keyboardButtonPosition = config.stringValue("LoginScreen.MenuArea.Keyboard/position");
        const keyboardButtonIndex = config.intValue("LoginScreen.MenuArea.Keyboard/index");

        // LoginScreen.MenuArea.Language
        const layoutButtonDisplay = config["LoginScreen.MenuArea.Layout/display"] === "false" ? false : true;
        const layoutButtonPosition = config.stringValue("LoginScreen.MenuArea.Layout/position");
        const layoutButtonIndex = config.intValue("LoginScreen.MenuArea.Layout/index");

        // LoginScreen.MenuArea.Power
        const powerButtonDisplay = config["LoginScreen.MenuArea.Power/display"] === "false" ? false : true;
        const powerButtonPosition = config.stringValue("LoginScreen.MenuArea.Power/position");
        const powerButtonIndex = config.intValue("LoginScreen.MenuArea.Power/index");

        const menus = [];
        const available_positions = ["top-left", "top-center", "top-right", "center-left", "center-right", "bottom-left", "bottom-center", "bottom-right"];

        if (sessionButtonDisplay)
            menus.push({
                name: "session",
                index: sessionButtonIndex,
                def_index: 0,
                position: available_positions.includes(sessionButtonPosition) ? sessionButtonPosition : "bottom-left"
            });

        if (layoutButtonDisplay)
            menus.push({
                name: "language",
                index: layoutButtonIndex,
                def_index: 1,
                position: available_positions.includes(layoutButtonPosition) ? layoutButtonPosition : "bottom-right"
            });

        if (keyboardButtonDisplay)
            menus.push({
                name: "keyboard",
                index: keyboardButtonIndex,
                def_index: 2,
                position: available_positions.includes(keyboardButtonPosition) ? keyboardButtonPosition : "bottom-right"
            });

        if (powerButtonDisplay)
            menus.push({
                name: "power",
                index: powerButtonIndex,
                def_index: 3,
                position: available_positions.includes(powerButtonPosition) ? powerButtonPosition : "bottom-right"
            });

        // Sort by index or default index if 0
        return menus.sort((c, n) => c.index - n.index || c.def_index - n.def_index);
    }

    function getIcon(iconName) {
        return `../icons/${iconName}`;
    }
}
