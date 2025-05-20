pragma Singleton

import QtQuick

/*
    `config["option"]` is used in some places instead of `config.boolValue("option")` so we can default to `true`.
    https://github.com/sddm/sddm/wiki/Theming#new-explicitly-typed-api-since-sddm-020
*/
QtObject {
    // General
    property string font: ""
    property color textColor: config.stringValue("text_color") || "#FFFFFF"
    property color activeTextColor: config.stringValue("active_text_color") || "#FFFFFF"
    property color backgroundColor: config.stringValue("background_color") || "#FFFFFF"
    property color activeBackgroundColor: config.stringValue("active_background_color") || "#FFFFFF"
    property real backgroundOpacity: clampReal("background_opacity", 0.0, 1.0)
    property real activeBackgroundOpacity: clampReal("active_background_opacity", 0.0, 1.0)
    property bool enableAnimations: config['enable_animations'] === "false" ? false : true
    property int blurRadius: clampInt("blur_radius", 0, 100)

    // LockScreen
    property bool displayLockScreen: config['LockScreen/display'] === "false" ? false : true
    property string lockScreenBackground: config.stringValue("LockScreen/background") || "backgrounds/default.jpg"
    property real lockScreenBlur: clampReal("LockScreen/blur", 0.0, 1.0)
    property bool centerClock: config.boolValue("LockScreen/center_clock_and_date")

    // LockScreen.Clock
    property bool displayClock: config['LockScreen.Clock/display'] === "false" ? false : true
    property string clockFormat: config.stringValue("LockScreen.Clock/format") || "hh:mm"
    property int clockFontSize: config.intValue("LockScreen.Clock/font_size") || 60
    property color clockColor: config.stringValue("LockScreen.Clock/color") || "#FFFFFF"
    property int clockMarginTop: config.intValue("LockScreen.Clock/margin_top")

    // LockScreen.Date
    property bool displayDate: config['LockScreen.Date/display'] === "false" ? false : true
    property string dateFormat: config.stringValue("LockScreen.Date/format") || "dddd, MMMM dd, yyyy"
    property int dateFontSize: config.intValue("LockScreen.Date/font_size") || 12
    property color dateColor: config.stringValue("LockScreen.Date/color") || "#FFFFFF"
    property int dateMarginTop: config.intValue("LockScreen.Date/margin_top")

    // LockScreen.PressAnyKey
    property bool displayPAK: config['LockScreen.PressAnyKey/display'] === "false" ? false : true
    property int pakFontSize: config.intValue("LockScreen.PressAnyKey/font_size") || 9
    property int pakIconSize: config.intValue("LockScreen.PressAnyKey/icon_size") || 18
    property color pakColor: config.stringValue("LockScreen.PressAnyKey/color") || "#FFFFFF"
    property int pakMarginBottom: config.intValue("LockScreen.PressAnyKey/margin_bottom")

    // LoginScreen
    property string loginScreenBackground: config.stringValue("LoginScreen/background") || "backgrounds/default.jpg"
    property real loginScreenBlur: clampReal("LoginScreen/blur", 0.0, 1.0)

    // LoginScreen.LoginArea
    property bool centerLoginArea: config["LoginScreen.LoginArea/certer_vertically"] === "false" ? false : true
    property int loginAreaMarginTop: config.intValue("LoginScreen.LoginArea/margin_top")

    function clampReal(cfg, min, max, def = null) {
        let v = config.realValue(cfg);
        if (def !== null)
            v = v || def;
        return Math.min(Math.max(v, min), max);
    }
    function clampInt(cfg, min, max, def = null) {
        let v = config.intValue(cfg);
        if (def !== null)
            v = v || def;
        return Math.min(Math.max(v, min), max);
    }

    function sortMenuButtons() {
        // LoginScreen.MenuArea.Session
        const sessionButtonDisplay = config["LoginScreen.MenuArea.Session/display"] === "false" ? false : true;
        const sessionButtonPosition = config.stringValue("LoginScreen.MenuArea.Session/position");
        const sessionButtonIndex = clampInt(config.intValue("LoginScreen.MenuArea.Session/index"), 0, 4);
        const sessionButtonPopupDirection = config.stringValue("LoginScreen.MenuArea.Session/popup_direction") || "up";
        const sessionButtonBackgroundColor = config.stringValue("LoginScreen.MenuArea.Session/button_background_color") || "#FFFFFF";
        const sessionButtonTextColor = config.stringValue("LoginScreen.MenuArea.Session/text_color") || "#FFFFFF";
        const sessionButtonIconSize = config.intValue("LoginScreen.MenuArea.Session/icon_size") || 16;
        const sessionButtonDisplayName = config["LoginScreen.MenuArea.Session/display_session_name"] === "false" ? false : true;

        // LoginScreen.MenuArea.Keyboard
        const keyboardButtonDisplay = config["LoginScreen.MenuArea.Keyboard/display"] === "false" ? false : true;
        const keyboardButtonPosition = config.stringValue("LoginScreen.MenuArea.Keyboard/position");
        const keyboardButtonIndex = clampInt(config.intValue("LoginScreen.MenuArea.Keyboard/index"), 0, 4);
        const keyboardButtonBackgroundColor = config.stringValue("LoginScreen.MenuArea.Keyboard/button_background_color") || "#FFFFFF";
        const keyboardButtonTextColor = config.stringValue("LoginScreen.MenuArea.Keyboard/text_color") || "#FFFFFF";
        const keyboardButtonIconSize = config.intValue("LoginScreen.MenuArea.Keyboard/icon_size") || 16;

        // LoginScreen.MenuArea.Language
        const languageButtonDisplay = config["LoginScreen.MenuArea.Language/display"] === "false" ? false : true;
        const languageButtonPosition = config.stringValue("LoginScreen.MenuArea.Language/position");
        const languageButtonIndex = clampInt(config.intValue("LoginScreen.MenuArea.Language/index"), 0, 4);
        const languageButtonPopupDirection = config.stringValue("LoginScreen.MenuArea.Language/popup_direction") || "up";
        const languageButtonBackgroundColor = config.stringValue("LoginScreen.MenuArea.Language/button_background_color") || "#FFFFFF";
        const languageButtonTextColor = config.stringValue("LoginScreen.MenuArea.Language/text_color") || "#FFFFFF";
        const languageButtonIconSize = config.intValue("LoginScreen.MenuArea.Language/icon_size") || 16;
        const languageButtonDisplayName = config["LoginScreen.MenuArea.Language/display_language_name"] === "false" ? false : true;

        // LoginScreen.MenuArea.Power
        const powerButtonDisplay = config["LoginScreen.MenuArea.Power/display"] === "false" ? false : true;
        const powerButtonPosition = config.stringValue("LoginScreen.MenuArea.Power/position");
        const powerButtonIndex = clampInt(config.intValue("LoginScreen.MenuArea.Power/index"), 0, 4);
        const powerButtonPopupDirection = config.stringValue("LoginScreen.MenuArea.Power/popup_direction") || "up";
        const powerButtonBackgroundColor = config.stringValue("LoginScreen.MenuArea.Power/button_background_color") || "#FFFFFF";
        const powerButtonTextColor = config.stringValue("LoginScreen.MenuArea.Power/text_color") || "#FFFFFF";
        const powerButtonIconSize = config.intValue("LoginScreen.MenuArea.Power/icon_size") || 16;

        const buttons = [];
        const available_positions = ["top_left", "top_center", "top_right", "bottom_left", "bottom_center", "bottom_right"];

        if (sessionButtonDisplay)
            buttons.push({
                text: true,
                position: sessionButtonPosition in available_positions ? sessionButtonPosition : "bottom_left",
                index: sessionButtonIndex,
                popup_direction: sessionButtonPopupDirection,
                background_color: sessionButtonBackgroundColor,
                text_color: sessionButtonTextColor,
                icon_size: sessionButtonIconSize,
                display_name: sessionButtonDisplayName,
                id: "sessionButton"
            });

        if (keyboardButtonDisplay)
            buttons.push({});

        if (languageButtonDisplay)
            buttons.push({});

        if (powerButtonDisplay)
            buttons.push({});

        return buttons.sort((c, n) => c.a - n.a);
    }
}
