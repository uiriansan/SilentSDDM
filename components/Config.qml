pragma Singleton

import QtQuick

/*
    `config["option"]` is used in some places instead of `config.boolValue("option")` so we can default to `true`.
    https://github.com/sddm/sddm/wiki/Theming#new-explicitly-typed-api-since-sddm-020
*/
QtObject {
    // [General]
    property bool enableAnimations: config['enable-animations'] === "false" ? false : true
    property string animatedBackgroundPlaceholder: config.stringValue("animated-background-placeholder")

    // [LockScreen]
    property bool lockScreenDisplay: config['LockScreen/display'] === "false" ? false : true
    property int lockScreenPaddingTop: config.intValue("LockScreen/padding-top")
    property int lockScreenPaddingRight: config.intValue("LockScreen/padding-right")
    property int lockScreenPaddingBottom: config.intValue("LockScreen/padding-bottom")
    property int lockScreenPaddingLeft: config.intValue("LockScreen/padding-left")
    property string lockScreenBackground: config.stringValue("LockScreen/background") || "default.jpg"
    property bool lockScreenUseBackgroundColor: config.boolValue('LockScreen/use-background-color')
    property color lockScreenBackgroundColor: config.stringValue("LockScreen/background-color") || "#000000"
    property int lockScreenBlur: config.intValue("LockScreen/blur")
    property real lockScreenBrightness: config.realValue("LockScreen/brightness")

    // [LockScreen.Clock]
    property bool clockDisplay: config['LockScreen.Clock/display'] === "false" ? false : true
    property string clockPosition: config.stringValue("LockScreen.Clock/position") || "top-center"
    property string clockAlign: config.stringValue("LockScreen.Clock/align") || "center"
    property string clockFormat: config.stringValue("LockScreen.Clock/format") || "hh:mm"
    property string clockFontFamily: config.stringValue("LockScreen.Clock/font-family") || "RedHatDisplay"
    property int clockFontSize: config.intValue("LockScreen.Clock/font-size") || 70
    property int clockFontWeight: config.intValue("LockScreen.Clock/font-weight") || 900
    property color clockColor: config.stringValue("LockScreen.Clock/color") || "#FFFFFF"

    // [LockScreen.Date]
    property bool dateDisplay: config['LockScreen.Date/display'] === "false" ? false : true
    property string dateFormat: config.stringValue("LockScreen.Date/format") || "dddd, MMMM dd, yyyy"
    property string dateFontFamily: config.stringValue("LockScreen.Date/font-family") || "RedHatDisplay"
    property int dateFontSize: config.intValue("LockScreen.Date/font-size") || 14
    property int dateFontWeight: config.intValue("LockScreen.Date/font-weight") || 400
    property color dateColor: config.stringValue("LockScreen.Date/color") || "#FFFFFF"
    property int dateMarginTop: config.intValue("LockScreen.Date/margin-top")

    // [LockScreen.Message]
    property bool lockMessageDisplay: config['LockScreen.Message/display'] === "false" ? false : true
    property string lockMessagePosition: config.stringValue("LockScreen.Message/position") || "bottom-center"
    property string lockMessageAlign: config.stringValue("LockScreen.Message/align") || "center"
    property string lockMessageText: config.stringValue("LockScreen.Message/text") || "Press any key"
    property string lockMessageFontFamily: config.stringValue("LockScreen.Message/font-family") || "RedHatDisplay"
    property int lockMessageFontSize: config.intValue("LockScreen.Message/font-size") || 12
    property int lockMessageFontWeight: config.intValue("LockScreen.Message/font-weight") || 400
    property string lockMessageIcon: config.stringValue("LockScreen.Message/icon") || "enter.svg"
    property int lockMessageIconSize: config.intValue("LockScreen.Message/icon-size") || 16
    property color lockMessageColor: config.stringValue("LockScreen.Message/color") || "#FFFFFF"
    property int lockMessageSpacing: config.intValue("LockScreen.Message/spacing")

    // [LoginScreen] *
    property int loginScreenPaddingTop: config.intValue("LoginScreen/padding-top")
    property int loginScreenPaddingRight: config.intValue("LoginScreen/padding-right")
    property int loginScreenPaddingBottom: config.intValue("LoginScreen/padding-bottom")
    property int loginScreenPaddingLeft: config.intValue("LoginScreen/padding-left")
    property string loginScreenBackground: config.stringValue("LoginScreen/background") || "default.jpg"
    property bool loginScreenUseBackgroundColor: config.boolValue('LoginScreen/use-background-color')
    property color loginScreenBackgroundColor: config.stringValue("LoginScreen/background-color") || "#000000"
    property int loginScreenBlur: config.intValue("LoginScreen/blur")
    property real loginScreenBrightness: config.realValue("LoginScreen/brightness")

    // [LoginScreen.LoginArea] *
    property string loginAreaPosition: config.stringValue("LoginScreen.LoginArea/position") || "center"
    property string loginAreaAlign: config.stringValue("LoginScreen.LoginArea/align") || "center"

    // [LoginScreen.LoginArea.Avatar]
    property string avatarShape: config.stringValue("LoginScreen.LoginArea.Avatar/shape") || "circle"
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
    property string passwordInputIcon: config.stringValue("LoginScreen.LoginArea.PasswordInput/icon") || "password.svg"
    property int passwordInputIconSize: config.intValue("LoginScreen.LoginArea.PasswordInput/icon-size") || 16
    property color passwordInputContentColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/content-color") || "#FFFFFF"
    property color passwordInputBackgroundColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/background-color") || "#FFFFFF"
    property real passwordInputBackgroundOpacity: config.realValue("LoginScreen.LoginArea.PasswordInput/background-opacity")
    property int passwordInputBorderSize: config.intValue("LoginScreen.LoginArea.PasswordInput/border-size")
    property color passwordInputBorderColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/border-color") || "#FFFFFF"
    property int passwordInputBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-left")
    property int passwordInputBorderRadiusRight: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-right")
    property int passwordInputMarginTop: config.intValue("LoginScreen.LoginArea.PasswordInput/margin-top")

    // [LoginScreen.LoginArea.LoginButton]
    property color loginButtonBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/background-color") || "#FFFFFF"
    property real loginButtonBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/background-opacity")
    property color loginButtonActiveBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-background-color") || "#FFFFFF"
    property real loginButtonActiveBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/active-background-opacity")
    property string loginButtonIcon: config.stringValue("LoginScreen.LoginArea.LoginButton/icon") || "arrow-right.svg"
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
    property string spinnerIcon: config.stringValue("LoginScreen.LoginArea.Spinner/icon") || "spinner.svg"

    // [LoginScreen.LoginArea.WarningMessage]
    property string warningMessageFontFamily: config.stringValue("LoginScreen.LoginArea.WarningMessage/font-family") || "RedHatDisplay"
    property int warningMessageFontSize: config.intValue("LoginScreen.LoginArea.WarningMessage/font-size") || 11
    property int warningMessageFontWeight: config.intValue("LoginScreen.LoginArea.WarningMessage/font-weight") || 400
    property color warningMessageNormalColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/normal-color") || "#FFFFFF"
    property color warningMessageWarningColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/warning-color") || "#FFFFFF"
    property color warningMessageErrorColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/error-color") || "#FFFFFF"
    property int warningMessageMarginTop: config.intValue("LoginScreen.LoginArea.WarningMessage/margin-top")

    // [LoginScreen.MenuArea.Buttons]
    property int menuAreaButtonsSize: config.intValue("LoginScreen.MenuArea.Buttons/size") || passwordInputHeight
    property int menuAreaButtonsBorderRadius: config.intValue("LoginScreen.MenuArea.Buttons/border-radius")
    property int menuAreaButtonsSpacing: config.intValue("LoginScreen.MenuArea.Buttons/spacing")
    property string menuAreaButtonsFontFamily: config.stringValue("LoginScreen.MenuArea.Buttons/font-family") || "RedHatDisplay"

    // [LoginScreen.MenuArea.Popups]
    property int menuAreaPopupsMaxHeight: config.intValue("LoginScreen.MenuArea.Popups/max-height") || 300
    property int menuAreaPopupsItemHeight: config.intValue("LoginScreen.MenuArea.Popups/item-height") || 35
    property int menuAreaPopupsSpacing: config.intValue("LoginScreen.MenuArea.Popups/item-spacing")
    property int menuAreaPopupsPadding: config.intValue("LoginScreen.MenuArea.Popups/padding")
    property int menuAreaPopupsMargin: config.intValue("LoginScreen.MenuArea.Popups/margin")
    property color menuAreaPopupsBackgroundColor: config.stringValue("LoginScreen.MenuArea.Popups/background-color") || "#FFFFFF"
    property real menuAreaPopupsBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Popups/background-opacity")
    property color menuAreaPopupsActiveOptionBackgroundColor: config.stringValue("LoginScreen.MenuArea.Popups/active-option-background-color") || "#FFFFFF"
    property real menuAreaPopupsActiveOptionBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Popups/active-option-background-opacity")
    property color menuAreaPopupsContentColor: config.stringValue("LoginScreen.MenuArea.Popups/content-color") || "#FFFFFF"
    property color menuAreaPopupsActiveContentColor: config.stringValue("LoginScreen.MenuArea.Popups/active-content-color") || "#FFFFFF"
    property string menuAreaPopupsFontFamily: config.stringValue("LoginScreen.MenuArea.Popups/font-family") || "RedHatDisplay"
    property int menuAreaPopupsFontSize: config.intValue("LoginScreen.MenuArea.Popups/font-size") || 11
    property int menuAreaPopupsIconSize: config.intValue("LoginScreen.MenuArea.Popups/icon-size") || 16

    // [LoginScreen.MenuArea.Session]
    property string sessionPopupDirection: config.stringValue("LoginScreen.MenuArea.Session/popup-direction") || "up"
    property bool sessionDisplaySessionName: config['LoginScreen.MenuArea.Session/display-session-name'] === "false" ? false : true
    property int sessionMaxWidth: config.intValue("LoginScreen.MenuArea.Session/max-width") || 200
    property color sessionBackgroundColor: config.stringValue("LoginScreen.MenuArea.Session/background-color") || "#FFFFFF"
    property real sessionBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/background-opacity")
    property real sessionActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/active-background-opacity")
    property color sessionContentColor: config.stringValue("LoginScreen.MenuArea.Session/content-color") || "#FFFFFF"
    property color sessionActiveContentColor: config.stringValue("LoginScreen.MenuArea.Session/active-content-color") || "#FFFFFF"
    property int sessionBorderSize: config.intValue("LoginScreen.MenuArea.Session/border-size")
    property int sessionFontSize: config.intValue("LoginScreen.MenuArea.Session/font-size") || 10
    property int sessionIconSize: config.intValue("LoginScreen.MenuArea.Session/icon-size") || 16

    // [LoginScreen.MenuArea.Layout]
    property string layoutPopupDirection: config.stringValue("LoginScreen.MenuArea.Layout/popup-direction") || "up"
    property int layoutPopupWidth: config.intValue("LoginScreen.MenuArea.Layout/popup-width") || 180
    property bool layoutDisplayLayoutName: config['LoginScreen.MenuArea.Layout/display-layout-name'] === "false" ? false : true
    property color layoutBackgroundColor: config.stringValue("LoginScreen.MenuArea.Layout/background-color") || "#FFFFFF"
    property real layoutBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Layout/background-opacity")
    property real layoutActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Layout/active-background-opacity")
    property color layoutContentColor: config.stringValue("LoginScreen.MenuArea.Layout/content-color") || "#FFFFFF"
    property color layoutActiveContentColor: config.stringValue("LoginScreen.MenuArea.Layout/active-content-color") || "#FFFFFF"
    property int layoutBorderSize: config.intValue("LoginScreen.MenuArea.Layout/border-size")
    property int layoutFontSize: config.intValue("LoginScreen.MenuArea.Layout/font-size") || 10
    property string layoutIcon: config.stringValue("LoginScreen.MenuArea.Layout/icon") || "language.svg"
    property int layoutIconSize: config.intValue("LoginScreen.MenuArea.Layout/icon-size") || 16

    // [LoginScreen.MenuArea.Keyboard]
    property color keyboardBackgroundColor: config.stringValue("LoginScreen.MenuArea.Keyboard/background-color") || "#FFFFFF"
    property real keyboardBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Keyboard/background-opacity")
    property real keyboardActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Keyboard/active-background-opacity")
    property color keyboardContentColor: config.stringValue("LoginScreen.MenuArea.Keyboard/content-color") || "#FFFFFF"
    property color keyboardActiveContentColor: config.stringValue("LoginScreen.MenuArea.Keyboard/active-content-color") || "#FFFFFF"
    property int keyboardBorderSize: config.intValue("LoginScreen.MenuArea.Keyboard/border-size")
    property string keyboardIcon: config.stringValue("LoginScreen.MenuArea.Keyboard/icon") || "keyboard.svg"
    property int keyboardIconSize: config.intValue("LoginScreen.MenuArea.Keyboard/icon-size") || 16

    // [LoginScreen.MenuArea.Power]
    property string powerPopupDirection: config.stringValue("LoginScreen.MenuArea.Power/popup-direction") || "up"
    property int powerPopupWidth: config.intValue("LoginScreen.MenuArea.Power/popup-width") || 100
    property color powerBackgroundColor: config.stringValue("LoginScreen.MenuArea.Power/background-color") || "#FFFFFF"
    property real powerBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Power/background-opacity")
    property real powerActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Power/active-background-opacity")
    property color powerContentColor: config.stringValue("LoginScreen.MenuArea.Power/content-color") || "#FFFFFF"
    property color powerActiveContentColor: config.stringValue("LoginScreen.MenuArea.Power/active-content-color") || "#FFFFFF"
    property int powerBorderSize: config.intValue("LoginScreen.MenuArea.Power/border-size")
    property string powerIcon: config.stringValue("LoginScreen.MenuArea.Power/icon") || "power.svg"
    property int powerIconSize: config.intValue("LoginScreen.MenuArea.Power/icon-size") || 16

    // [LoginScreen.VirtualKeyboard]
    property int virtualKeyboardScale: config.realValue("LoginScreen.VirtualKeyboard/scale") || 1.0
    property string virtualKeyboardPosition: config.stringValue("LoginScreen.VirtualKeyboard/position") || "bottom"
    property bool virtualKeyboardStartHidden: config['LoginScreen.VirtualKeyboard/start-hidden'] === "false" ? false : true
    property color virtualKeyboardBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/background-color") || "#FFFFFF"
    property real virtualKeyboardBackgroundOpacity: config.realValue("LoginScreen.VirtualKeyboard/background-opacity")
    property color virtualKeyboardKeyContentColor: config.stringValue("LoginScreen.VirtualKeyboard/key-content-color") || "#FFFFFF"
    property color virtualKeyboardKeyColor: config.stringValue("LoginScreen.VirtualKeyboard/key-color") || "#FFFFFF"
    property real virtualKeyboardKeyOpacity: config.realValue("LoginScreen.VirtualKeyboard/key-opacity")
    property color virtualKeyboardKeyActiveBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/key-active-background-color") || "#FFFFFF"
    property real virtualKeyboardKeyActiveOpacity: config.realValue("LoginScreen.VirtualKeyboard/key-active-opacity")
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
    property real tooltipsBackgroundOpacity: config.realValue("Tooltips/background-opacity")
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
