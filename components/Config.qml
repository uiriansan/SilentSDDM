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
    property bool loginScreenBlur: clampReal("LoginScreen/blur", 0.0, 1.0)

    // LoginScreen.LoginArea
    property bool centerLoginArea: config["LoginScreen.LoginArea/certer_vertically"] === "false" ? false : true
    property int loginAreaMarginTop: config.intValue("LoginScreen.LoginArea/margin_top")

    function clampReal(config, min, max, def = null) {
        let v = config.realValue(config);
        if (def !== null)
            v = v || def;
        return Math.min(Math.max(v, min), max);
    }
    function clampInt(config, min, max, def = null) {
        let v = config.intValue(config);
        if (def !== null)
            v = v || def;
        return Math.min(Math.max(v, min), max);
    }

    function sortMenuButtons() {
        return true;
    }
}
