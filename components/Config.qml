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

    // LoginScreen.MenuArea.Session
    property string sessionButtonPopupDirection: config.stringValue("LoginScreen.MenuArea.Session/popup_direction") || "up"
    property color sessionButtonBackgroundColor: config.stringValue("LoginScreen.MenuArea.Session/button_background_color") || "#FFFFFF"
    property color sessionButtonTextColor: config.stringValue("LoginScreen.MenuArea.Session/text_color") || "#FFFFFF"
    property int sessionButtonIconSize: config.intValue("LoginScreen.MenuArea.Session/icon_size") || 16
    property bool sessionButtonDisplayName: config["LoginScreen.MenuArea.Session/display_session_name"] === "false" ? false : true

    // LoginScreen.MenuArea.Language
    property string languageButtonPopupDirection: config.stringValue("LoginScreen.MenuArea.Language/popup_direction") || "up"
    property color languageButtonBackgroundColor: config.stringValue("LoginScreen.MenuArea.Language/button_background_color") || "#FFFFFF"
    property color languageButtonTextColor: config.stringValue("LoginScreen.MenuArea.Language/text_color") || "#FFFFFF"
    property int languageButtonIconSize: config.intValue("LoginScreen.MenuArea.Language/icon_size") || 16
    property bool languageButtonDisplayName: config["LoginScreen.MenuArea.Language/display_language_name"] === "false" ? false : true

    // LoginScreen.MenuArea.Keyboard
    property color keyboardButtonBackgroundColor: config.stringValue("LoginScreen.MenuArea.Keyboard/button_background_color") || "#FFFFFF"
    property color keyboardButtonTextColor: config.stringValue("LoginScreen.MenuArea.Keyboard/text_color") || "#FFFFFF"
    property int keyboardButtonIconSize: config.intValue("LoginScreen.MenuArea.Keyboard/icon_size") || 16

    // LoginScreen.MenuArea.Power
    property string powerButtonPopupDirection: config.stringValue("LoginScreen.MenuArea.Power/popup_direction") || "up"
    property color powerButtonBackgroundColor: config.stringValue("LoginScreen.MenuArea.Power/button_background_color") || "#FFFFFF"
    property color powerButtonTextColor: config.stringValue("LoginScreen.MenuArea.Power/text_color") || "#FFFFFF"
    property int powerButtonIconSize: config.intValue("LoginScreen.MenuArea.Power/icon_size") || 16

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

        // LoginScreen.MenuArea.Keyboard
        const keyboardButtonDisplay = config["LoginScreen.MenuArea.Keyboard/display"] === "false" ? false : true;
        const keyboardButtonPosition = config.stringValue("LoginScreen.MenuArea.Keyboard/position");
        const keyboardButtonIndex = clampInt(config.intValue("LoginScreen.MenuArea.Keyboard/index"), 0, 4);

        // LoginScreen.MenuArea.Language
        const languageButtonDisplay = config["LoginScreen.MenuArea.Language/display"] === "false" ? false : true;
        const languageButtonPosition = config.stringValue("LoginScreen.MenuArea.Language/position");
        const languageButtonIndex = clampInt(config.intValue("LoginScreen.MenuArea.Language/index"), 0, 4);

        // LoginScreen.MenuArea.Power
        const powerButtonDisplay = config["LoginScreen.MenuArea.Power/display"] === "false" ? false : true;
        const powerButtonPosition = config.stringValue("LoginScreen.MenuArea.Power/position");
        const powerButtonIndex = clampInt(config.intValue("LoginScreen.MenuArea.Power/index"), 0, 4);

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
