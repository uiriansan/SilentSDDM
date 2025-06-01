pragma Singleton

import QtQuick

/*
    `config["option"]` is used in some places instead of `config.boolValue("option")` so we can default to `true`.
    https://github.com/sddm/sddm/wiki/Theming#new-explicitly-typed-api-since-sddm-020
*/
QtObject {
    // [General]
    property string fontFamily: config.stringValue("font-family") || "RedHatDisplay"
    property bool enableAnimations: config['enable-animations'] === "false" ? false : true
    property int blurRadius: config.intValue("blur-radius") || 32

    // [LockScreen]
    property bool lockScreenDisplay: config['LockScreen/display'] === "false" ? false : true
    property string lockScreenBackground: config.stringValue("LockScreen/background") || "backgrounds/default.jpg"
    property bool lockScreenUseBackgroundColor: config.boolValue('LockScreen/use-background-color')
    property color lockScreenBackgroundColor: config.stringValue("LockScreen/background-color") || "#000000"
    property real lockScreenBlur: config.realValue("LockScreen/blur")
    property int lockScreenPadding: config.intValue("LockScreen/padding")

    // [LockScreen.Clock]
    property bool clockDisplay: config['LockScreen.Clock/display'] === "false" ? false : true
    // property string clockPosition: config.stringValue("LockScreen.Clock/position") || "center"
    // property bool clockCenterVertically: config.boolValue("LockScreen.Clock/center-vertically")
    property string clockFormat: config.stringValue("LockScreen.Clock/format") || "hh:mm"
    property int clockFontSize: config.intValue("LockScreen.Clock/font-size") || 60
    property color clockColor: config.stringValue("LockScreen.Clock/color") || "#FFFFFF"

    // [LockScreen.Date]
    property bool dateDisplay: config['LockScreen.Date/display'] === "false" ? false : true
    property string dateFormat: config.stringValue("LockScreen.Date/format") || "dddd, MMMM dd, yyyy"
    property int dateFontSize: config.intValue("LockScreen.Date/font-size") || 12
    property color dateColor: config.stringValue("LockScreen.Date/color") || "#FFFFFF"
    property int dateMarginTop: config.intValue("LockScreen.Date/margin-top")

    // [LockScreen.PressAnyKey]
    property bool pressAnyKeyDisplay: config['LockScreen.PressAnyKey/display'] === "false" ? false : true
    // property string pressAnyKeyPosition: config.stringValue("LockScreen.PressAnyKey/position") || "center"
    // property bool pressAnyKeyCenterVertically: config.boolValue("LockScreen.PressAnyKey/center-vertically")
    property string pressAnyKeyText: config.stringValue("LockScreen.PressAnyKey/text") || "Press any key"
    property int pressAnyKeyFontSize: config.intValue("LockScreen.PressAnyKey/font-size") || 9
    property int pressAnyKeyIconSize: config.intValue("LockScreen.PressAnyKey/icon-size") || 18
    property color pressAnyKeyColor: config.stringValue("LockScreen.PressAnyKey/color") || "#FFFFFF"

    // [LoginScreen]
    property string loginScreenBackground: config.stringValue("LoginScreen/background") || "backgrounds/default.jpg"
    property bool loginScreenUseBackgroundColor: config.boolValue('LoginScreen/use-background-color')
    property color loginScreenBackgroundColor: config.stringValue("LoginScreen/background-color") || "#000000"
    property real loginScreenBlur: config.realValue("LoginScreen/blur")
    property int loginScreenPaddingTop: config.intValue("LoginScreen/padding-top")
    property int loginScreenPaddingRight: config.intValue("LoginScreen/padding-right")
    property int loginScreenPaddingBottom: config.intValue("LoginScreen/padding-bottom")
    property int loginScreenPaddingLeft: config.intValue("LoginScreen/padding-left")

    // [LoginScreen.LoginArea]
    property string loginAreaPosition: config.stringValue("LoginScreen.LoginArea/position") || "center"
    property string loginAreaAlign: config.stringValue("LoginScreen.LoginArea/align") || "center"

    // [LoginScreen.LoginArea.Avatar]
    property string avatarShape: config.stringValue("LoginScreen.LoginArea.Avatar/shape") || "circle"
    property int avatarActiveSize: config.intValue("LoginScreen.LoginArea.Avatar/active-size") || 120
    property int avatarInactiveSize: config.intValue("LoginScreen.LoginArea.Avatar/inactive-size") || 80
    property real avatarInactiveOpacity: config.realValue("LoginScreen.LoginArea.Avatar/inactive-opacity") || 0.35
    property int avatarBorderSize: config.intValue("LoginScreen.LoginArea.Avatar/active-border-size")
    property int avatarInactiveBorderSize: config.intValue("LoginScreen.LoginArea.Avatar/inactive-border-size")
    property color avatarBorderColor: config.stringValue("LoginScreen.LoginArea.Avatar/border-color") || "#FFFFFF"
    property color avatarInactiveBorderColor: config.stringValue("LoginScreen.LoginArea.Avatar/inactive-border-color") || "#FFFFFF"
    property int avatarBorderRadius: config.intValue("LoginScreen.LoginArea.Avatar/border-radius")
    property bool avatarShadow: config['LoginScreen.LoginArea.Avatar/shadow'] === "false" ? false : true

    // [LoginScreen.LoginArea.Username]
    property int usernameFontSize: config.intValue("LoginScreen.LoginArea.Username/font-size") || 15
    property int usernameFontWeight: config.intValue("LoginScreen.LoginArea.Username/font-weight")
    property color usernameColor: config.stringValue("LoginScreen.LoginArea.Username/color") || "#FFFFFF"
    property int usernameMarginTop: config.intValue("LoginScreen.LoginArea.Username/margin-top")

    // [LoginScreen.LoginArea.PasswordInput]
    property int passwordInputWidth: config.intValue("LoginScreen.LoginArea.PasswordInput/width") || 200
    property int passwordInputHeight: config.intValue("LoginScreen.LoginArea.PasswordInput/height") || 30
    property color passwordInputTextColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/text-color") || "#FFFFFF"
    property int passwordInputFontSize: config.intValue("LoginScreen.LoginArea.PasswordInput/font-size") || 8
    property color passwordInputBackgroundColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/background-color") || "#FFFFFF"
    property real passwordInputBackgroundOpacity: config.realValue("LoginScreen.LoginArea.PasswordInput/background-opacity")
    // property int passwordInputBorderSize: config.intValue("LoginScreen.LoginArea.PasswordInput/border-size")
    // property color passwordInputBorderColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/border-color") || "#FFFFFF"
    // property int passwordInputBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-left")
    // property int passwordInputBorderRadiusRight: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-right")
    // property bool passwordInputCenterText: config.boolValue("LoginScreen.LoginArea.PasswordInput/center-text")
    // property bool passwordInputDisplayIcon: config['LoginScreen.LoginArea.PasswordInput/display-icon'] === "false" ? false : true
    property int passwordInputMarginTop: config.intValue("LoginScreen.LoginArea.PasswordInput/margin-top")

    // [LoginScreen.LoginArea.LoginButton]
    property color loginButtonBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/background-color") || "#FFFFFF"
    property real loginButtonBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/background-opacity")
    property color loginButtonActiveBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-background-color") || "#FFFFFF"
    property real loginButtonActiveBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/active-background-opacity")
    property int loginButtonIconSize: config.intValue("LoginScreen.LoginArea.LoginButton/icon-size") || 24
    property color loginButtonContentColor: config.stringValue("LoginScreen.LoginArea.LoginButton/content-color") || "#FFFFFF"
    property color loginButtonActiveContentColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-content-color") || "#FFFFFF"
    // property int loginButtonBorderSize: config.intValue("LoginScreen.LoginArea.LoginButton/border-size")
    // property color loginButtonBorderColor: config.stringValue("LoginScreen.LoginArea.LoginButton/border-color") || "#FFFFFF"
    // property int loginButtonBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.LoginButton/border-radius-left")
    // property int loginButtonBorderRadiusRight: config.intValue("LoginScreen.LoginArea.LoginButton/border-radius-right")
    property int loginButtonMarginLeft: config.intValue("LoginScreen.LoginArea.LoginButton/margin-left")
    property bool loginButtonShowTextIfNoPassword: config['LoginScreen.LoginArea.LoginButton/show-text-if-no-password'] === "false" ? false : true
    property int loginButtonFontSize: config.intValue("LoginScreen.LoginArea.LoginButton/font-size") || 8

    // [LoginScreen.LoginArea.Spinner]
    property int spinnerSize: config.intValue("LoginScreen.LoginArea.Spinner/size") || 32
    property color spinnerColor: config.stringValue("LoginScreen.LoginArea.Spinner/color") || "#FFFFFF"
    property int spinnerMarginTop: config.intValue("LoginScreen.LoginArea.Spinner/margin-top")

    // [LoginScreen.LoginArea.WarningMessage]
    property int warningMessageFontSize: config.intValue("LoginScreen.LoginArea.WarningMessage/font-size") || 8
    property bool warningMessageBold: config.boolValue("LoginScreen.LoginArea.WarningMessage/bold")
    property color warningMessageNormalColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/normal-color") || "#FFFFFF"
    property color warningMessageWarningColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/warning-color") || "#FFFFFF"
    property color warningMessageErrorColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/error-color") || "#FFFFFF"
    property int warningMessageMarginTop: config.intValue("LoginScreen.LoginArea.WarningMessage/margin-top")

    // [LoginScreen.MenuArea]
    property int menuAreaSpacing: config.intValue("LoginScreen.MenuArea/spacing")
    property int menuAreaButtonsBorderRadius: config.intValue("LoginScreen.MenuArea/buttons-border-radius")
    property int menuAreaButtonsSize: config.intValue("LoginScreen.MenuArea/buttons-size") || 30
    property color menuAreaPopupBackgroundColor: config.stringValue("LoginScreen.MenuArea/popup-background-color") || "#FFFFFF"
    property real menuAreaPopupBackgroundOpacity: config.realValue("LoginScreen.MenuArea/popup-background-opacity")
    property color menuAreaPopupActiveOptionBackgroundColor: config.stringValue("LoginScreen.MenuArea/popup-active-option-background-color") || "#FFFFFF"
    property real menuAreaPopupActiveOptionBackgroundOpacity: config.realValue("LoginScreen.MenuArea/popup-active-option-background-opacity")
    property color menuAreaPopupContentColor: config.stringValue("LoginScreen.MenuArea/popup-content-color") || "#FFFFFF"
    property color menuAreaPopupActiveContentColor: config.stringValue("LoginScreen.MenuArea/popup-active-content-color") || "#FFFFFF"
    property int menuAreaPopupFontSize: config.intValue("LoginScreen.MenuArea/popup-font-size") || 8
    property int menuAreaPopupIconSize: config.intValue("LoginScreen.MenuArea/popup-icon-size") || 16

    // [LoginScreen.MenuArea.Session]
    property string sessionPopupDirection: config.stringValue("LoginScreen.MenuArea.Session/popup-direction") || "up"
    property int sessionButonMaxWidth: config.intValue("LoginScreen.MenuArea.Session/button-max-width") || 200
    property color sessionButtonBackgroundColor: config.stringValue("LoginScreen.MenuArea.Session/button-background-color") || "#FFFFFF"
    property real sessionButtonBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/button-background-opacity")
    property real sessionButtonActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/button-active-background-opacity")
    property color sessionButtonContentColor: config.stringValue("LoginScreen.MenuArea.Session/button-content-color") || "#FFFFFF"
    property color sessionButtonActiveContentColor: config.stringValue("LoginScreen.MenuArea.Session/button-active-content-color") || "#FFFFFF"
    property int sessionButtonFontSize: config.intValue("LoginScreen.MenuArea.Session/button-font-size") || 8
    property int sessionButtonIconSize: config.intValue("LoginScreen.MenuArea.Session/button-icon-size") || 16
    property bool sessionButtonDisplaySessionName: config['LoginScreen.MenuArea.Session/button-display-session-name'] === "false" ? false : true

    // [LoginScreen.MenuArea.Language]
    property string languagePopupDirection: config.stringValue("LoginScreen.MenuArea.Language/popup-direction") || "up"
    property color languageButtonBackgroundColor: config.stringValue("LoginScreen.MenuArea.Language/button-background-color") || "#FFFFFF"
    property real languageButtonBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Language/button-background-opacity")
    property real languageButtonActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Language/button-active-background-opacity")
    property color languageButtonContentColor: config.stringValue("LoginScreen.MenuArea.Language/button-content-color") || "#FFFFFF"
    property color languageButtonActiveContentColor: config.stringValue("LoginScreen.MenuArea.Language/button-active-content-color") || "#FFFFFF"
    property int languageButtonFontSize: config.intValue("LoginScreen.MenuArea.Language/button-font-size") || 8
    property int languageButtonIconSize: config.intValue("LoginScreen.MenuArea.Language/button-icon-size") || 16
    property bool languageButtonDisplayLanguageName: config['LoginScreen.MenuArea.Language/button-display-language-name'] === "false" ? false : true

    // [LoginScreen.MenuArea.Keyboard]
    property color keyboardButtonBackgroundColor: config.stringValue("LoginScreen.MenuArea.Keyboard/button-background-color") || "#FFFFFF"
    property real keyboardButtonBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Keyboard/button-background-opacity")
    property real keyboardButtonActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Keyboard/button-active-background-opacity")
    property color keyboardButtonContentColor: config.stringValue("LoginScreen.MenuArea.Keyboard/button-content-color") || "#FFFFFF"
    property color keyboardButtonActiveContentColor: config.stringValue("LoginScreen.MenuArea.Keyboard/button-active-content-color") || "#FFFFFF"
    property int keyboardButtonIconSize: config.intValue("LoginScreen.MenuArea.Keyboard/button-icon-size") || 16

    // [LoginScreen.MenuArea.Power]
    property string powerPopupDirection: config.stringValue("LoginScreen.MenuArea.Power/popup-direction") || "up"
    property color powerButtonBackgroundColor: config.stringValue("LoginScreen.MenuArea.Power/button-background-color") || "#FFFFFF"
    property real powerButtonBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Power/button-background-opacity")
    property real powerButtonActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Power/button-active-background-opacity")
    property color powerButtonContentColor: config.stringValue("LoginScreen.MenuArea.Power/button-content-color") || "#FFFFFF"
    property color powerButtonActiveContentColor: config.stringValue("LoginScreen.MenuArea.Power/button-active-content-color") || "#FFFFFF"
    property int powerButtonIconSize: config.intValue("LoginScreen.MenuArea.Power/button-icon-size") || 16

    // [LoginScreen.VirtualKeyboard]
    property int virtualKeyboardScale: config.realValue("LoginScreen.VirtualKeyboard/scale") || 1.0
    property string virtualKeyboardPosition: config.stringValue("LoginScreen.VirtualKeyboard/position") || "bottom"
    property bool virtualKeyboardStartHidden: config['LoginScreen.VirtualKeyboard/start-hidden'] === "false" ? false : true
    // property color virtualKeyboardBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/background-color") || "#FFFFFF"
    // property real virtualKeyboardBackgroundOpacity: config.realValue("LoginScreen.VirtualKeyboard/background-opacity")
    // property color virtualKeyboardKeyTextColor: config.stringValue("LoginScreen.VirtualKeyboard/key-text-color") || "#FFFFFF"
    // property color virtualKeyboardKeyColor: config.stringValue("LoginScreen.VirtualKeyboard/key-color") || "#FFFFFF"
    // property real virtualKeyboardKeyOpacity: config.realValue("LoginScreen.VirtualKeyboard/key-opacity")
    // property color virtualKeyboardKeyActiveBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/key-active-background-color") || "#FFFFFF"
    // property real virtualKeyboardKeyActiveOpacity: config.realValue("LoginScreen.VirtualKeyboard/key-active-opacity")
    // property color virtualKeyboardSelectionBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/selection-background-color") || "#FFFFFF"
    // property real virtualKeyboardSelectionBackgroundOpacity: config.realValue("LoginScreen.VirtualKeyboard/selection-background-opacity")
    // property color virtualKeyboardSelectionTextColor: config.stringValue("LoginScreen.VirtualKeyboard/selection-text-color") || "#FFFFFF"
    // property color virtualKeyboardAccentColor: config.stringValue("LoginScreen.VirtualKeyboard/accent-color") || "#000000"

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
        const languageButtonDisplay = config["LoginScreen.MenuArea.Language/display"] === "false" ? false : true;
        const languageButtonPosition = config.stringValue("LoginScreen.MenuArea.Language/position");
        const languageButtonIndex = config.intValue("LoginScreen.MenuArea.Language/index");

        // LoginScreen.MenuArea.Power
        const powerButtonDisplay = config["LoginScreen.MenuArea.Power/display"] === "false" ? false : true;
        const powerButtonPosition = config.stringValue("LoginScreen.MenuArea.Power/position");
        const powerButtonIndex = config.intValue("LoginScreen.MenuArea.Power/index");

        const menus = [];
        const available_positions = ["top_left", "top_center", "top_right", "center_left", "center_right", "bottom_left", "bottom_center", "bottom_right"];

        if (sessionButtonDisplay)
            menus.push({
                name: "session",
                index: sessionButtonIndex,
                def_index: 0,
                position: sessionButtonPosition in available_positions ? sessionButtonPosition : "bottom_left"
            });

        if (languageButtonDisplay)
            menus.push({
                name: "language",
                index: languageButtonIndex,
                def_index: 1,
                position: languageButtonPosition in available_positions ? languageButtonPosition : "bottom_right"
            });

        if (keyboardButtonDisplay)
            menus.push({
                name: "keyboard",
                index: keyboardButtonIndex,
                def_index: 2,
                position: keyboardButtonPosition in available_positions ? keyboardButtonPosition : "bottom_right"
            });

        if (powerButtonDisplay)
            menus.push({
                name: "power",
                index: powerButtonIndex,
                def_index: 3,
                position: powerButtonPosition in available_positions ? powerButtonPosition : "bottom_right"
            });

        // Sort by index or default index if 0
        return menus.sort((c, n) => c.index - n.index || c.def_index - n.def_index);
    }
}
