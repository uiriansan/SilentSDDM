pragma Singleton

import QtQuick

/*
    `config["option"]` is used in some places instead of `config.boolValue("option")` so we can default to `true`.
    https://github.com/sddm/sddm/wiki/Theming#new-explicitly-typed-api-since-sddm-020
*/
QtObject {
    // [General]
    property bool enableAnimations: config['enable-animations'] === "false" ? false : true // @desc:Enable or disable all animations.
    property bool enableRippleEffect: config['enable-ripple-effect'] === "false" ? false : true // @desc:Enable or disable ripple effect on button clicks.
    property bool enableThemeLockout: config['enable-theme-lockout'] === "false" ? false : true // @desc:Enable theme-level lockout. If false, relies on PAM lockout only.
    property int maxLoginAttempts: config.intValue("max-login-attempts") || 3 // @desc:Maximum number of failed login attempts before lockout.
    property int lockoutDurationMinutes: config.intValue("lockout-duration-minutes") || 10 // @desc:Lockout duration in minutes after too many failed attempts.
    property string animatedBackgroundPlaceholder: config.stringValue("animated-background-placeholder") // @possible:File in `backgrounds/` @desc:An image file to be used as a placeholder for the animated background while it loads.

    // [LockScreen]
    property bool lockScreenDisplay: config['LockScreen/display'] === "false" ? false : true // @desc:Whether or not to display the lock screen. If false, the theme will load straight to the login screen.
    property int lockScreenPaddingTop: config.intValue("LockScreen/padding-top") // @desc:Top padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.
    property int lockScreenPaddingRight: config.intValue("LockScreen/padding-right") // @desc:Right padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.
    property int lockScreenPaddingBottom: config.intValue("LockScreen/padding-bottom") // @desc:Bottom padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.
    property int lockScreenPaddingLeft: config.intValue("LockScreen/padding-left") // @desc:Left padding of the lock screen. <br/>See also: <a href="#clockposition">Clock/position</a>, <a href="#lockmessageposition">Message/position</a>.
    property string lockScreenBackground: config.stringValue("LockScreen/background") || "default.jpg" // @possible:File in `backgrounds/` @desc:Background of the lock screen.<br/>Supported formats: jpg, png, avi, mp4, mov, mkv, m4v, webm. <strong>.gifs are not supported as they may cause SDDM to crash.</strong> <br/>See also: <a href="#animatedbackgroundplaceholder">animated-background-placeholder</a>
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
    property string lockMessageText: config.stringValue("LockScreen.Message/text") || textConstants.pressAnyKey || "Press any key" // @desc:Text of the custom message.
    property string lockMessageFontFamily: config.stringValue("LockScreen.Message/font-family") || "RedHatDisplay" // @desc:Font family used for the custom message.
    property int lockMessageFontSize: config.intValue("LockScreen.Message/font-size") || 12 // @desc:Font size of the custom message.
    property int lockMessageFontWeight: config.intValue("LockScreen.Message/font-weight") || 400 // @desc:Font weight of the date. 400 = regular, 600 = bold, 800 = black
    property bool lockMessageDisplayIcon: config['LockScreen.Message/display-icon'] === "false" ? false : true // @desc:Show or hide the icon above the message.
    property string lockMessageIcon: config.stringValue("LockScreen.Message/icon") || "enter.svg" // @possible:File in `icons/` @desc:Icon above the custom message.
    property int lockMessageIconSize: config.intValue("LockScreen.Message/icon-size") || 16 // @desc:Size of the custom message's icon.
    property color lockMessageColor: config.stringValue("LockScreen.Message/color") || "#FFFFFF" // @desc:Color of the custom message.
    property bool lockMessagePaintIcon: config['LockScreen.Message/paint-icon'] === "false" ? false : true // @desc:Whether or not to paint the icon with the same color as the text.
    property int lockMessageSpacing: config.intValue("LockScreen.Message/spacing") // @desc:Spacing between the icon and the text in the custom message.

    // [LoginScreen]
    property string loginScreenBackground: config.stringValue("LoginScreen/background") || "default.jpg" // @possible:File in `backgrounds/` @desc:Background of the login screen.<br/>Supported formats: jpg, png, avi, mp4, mov, mkv, m4v, webm. <strong>.gifs are not supported as they may cause SDDM to crash.</strong> <br/>See also: <a href="#animatedbackgroundplaceholder">animated-background-placeholder</a>
    property bool loginScreenUseBackgroundColor: config.boolValue('LoginScreen/use-background-color') // @desc:Whether or not to use a plain color as background of the login screen instead of an image/video file.
    property color loginScreenBackgroundColor: config.stringValue("LoginScreen/background-color") || "#000000" // @desc:The color to be used as background of the login screen. <br/>See also: <a href="#loginscreenusebackgroundcolor">use-background-color<a>
    property int loginScreenBlur: config.intValue("LoginScreen/blur") // @desc:Amount of blur to be applied to the background of the login screen. 0 means no blur.
    property real loginScreenBrightness: config.realValue("LoginScreen/brightness") // @possible:-1.0 ≤ R ≤ 1.0 @desc:Brightness of the background of the login screen. 0.0 leaves unchanged, -1.0 makes it black and 1.0 white.

    // [LoginScreen.LoginArea]
    property string loginAreaPosition: config.stringValue("LoginScreen.LoginArea/position") || "center" // @possible:'left' | 'center' | 'right' @desc:Position of the login area.
    property int loginAreaMargin: config.intValue("LoginScreen.LoginArea/margin") // @desc:Margin of the login area relative to its anchor point.<br/>If position is set to `center`, this option specifies the top margin, left/right margin otherwise.<br/><br/><strong>Set this option to `-1` to center the login area.</strong>

    // [LoginScreen.LoginArea.Avatar]
    property string avatarShape: config.stringValue("LoginScreen.LoginArea.Avatar/shape") || "circle" // @possible:'circle' || 'square' @desc:Shape of the avatar. <br/>See also: <a href="#avatarborderradius">border-radius<a>
    property int avatarBorderRadius: config.intValue("LoginScreen.LoginArea.Avatar/border-radius") // @desc:Border radius of the 'square' avatar. <br/>See also: <a href="#avatarshape">shape<a>
    property int avatarActiveSize: config.intValue("LoginScreen.LoginArea.Avatar/active-size") || 120 // @desc:Size of the selected user's avatar.
    property int avatarInactiveSize: config.intValue("LoginScreen.LoginArea.Avatar/inactive-size") || 80 // @desc:Size of the non-selected user avatars.
    property real avatarInactiveOpacity: config.realValue("LoginScreen.LoginArea.Avatar/inactive-opacity") || 0.35 // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the non-selected avatars.
    property int avatarActiveBorderSize: config.intValue("LoginScreen.LoginArea.Avatar/active-border-size") // @desc:Border size of the selected user's avatar.
    property int avatarInactiveBorderSize: config.intValue("LoginScreen.LoginArea.Avatar/inactive-border-size") // @desc:Border size of the non-selected avatars.
    property color avatarActiveBorderColor: config.stringValue("LoginScreen.LoginArea.Avatar/active-border-color") || "#FFFFFF" // @desc:Border color of the selected user's avatar.
    property color avatarInactiveBorderColor: config.stringValue("LoginScreen.LoginArea.Avatar/inactive-border-color") || "#FFFFFF" // @desc:Border color of the non-selected avatars.

    // [LoginScreen.LoginArea.Username]
    property string usernameFontFamily: config.stringValue("LoginScreen.LoginArea.Username/font-family") || "RedHatDisplay" // @desc:Font family used for the username.
    property int usernameFontSize: config.intValue("LoginScreen.LoginArea.Username/font-size") || 16 // @desc:Font size of the username.
    property int usernameFontWeight: config.intValue("LoginScreen.LoginArea.Username/font-weight") || 900 // @desc:Font weight of the username. 400 = regular, 600 = bold, 800 = black
    property color usernameColor: config.stringValue("LoginScreen.LoginArea.Username/color") || "#FFFFFF" // @desc:Color of the username.
    property int usernameMargin: config.intValue("LoginScreen.LoginArea.Username/margin") // @desc:Distance of the username from the avatar.

    // [LoginScreen.LoginArea.PasswordInput]
    property int passwordInputWidth: config.intValue("LoginScreen.LoginArea.PasswordInput/width") || 200 // @desc:Width of the password field.
    property int passwordInputHeight: config.intValue("LoginScreen.LoginArea.PasswordInput/height") || 30 // @desc:Height of the password field. This option also defines the size of the login button.
    property bool passwordInputDisplayIcon: config['LoginScreen.LoginArea.PasswordInput/display-icon'] === "false" ? false : true // @desc:Whether or not to display the icon in the password field.
    property string passwordInputFontFamily: config.stringValue("LoginScreen.LoginArea.PasswordInput/font-family") || "RedHatDisplay" // @desc:Font family of the password field.
    property int passwordInputFontSize: config.intValue("LoginScreen.LoginArea.PasswordInput/font-size") || 12 // @desc:Font size of the password field.
    property string passwordInputIcon: config.stringValue("LoginScreen.LoginArea.PasswordInput/icon") || "password.svg" // @possible:File in `icons/` @desc:Icon in the password field.
    property int passwordInputIconSize: config.intValue("LoginScreen.LoginArea.PasswordInput/icon-size") || 16 // @desc:Size of the icon inside the password field.
    property color passwordInputContentColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/content-color") || "#FFFFFF" // @desc:Color of text/icon in the password field.
    property color passwordInputBackgroundColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/background-color") || "#FFFFFF" // @desc:Background color of the password field.
    property real passwordInputBackgroundOpacity: config.realValue("LoginScreen.LoginArea.PasswordInput/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the password field.
    property int passwordInputBorderSize: config.intValue("LoginScreen.LoginArea.PasswordInput/border-size") // @desc:Size of the border of the password field.
    property color passwordInputBorderColor: config.stringValue("LoginScreen.LoginArea.PasswordInput/border-color") || "#FFFFFF" // @desc:Color of the border of the password field.
    property int passwordInputBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-left") // @desc:Left border radius of the password field.
    property int passwordInputBorderRadiusRight: config.intValue("LoginScreen.LoginArea.PasswordInput/border-radius-right") // @desc:Right border radius of the password field.
    property int passwordInputMarginTop: config.intValue("LoginScreen.LoginArea.PasswordInput/margin-top") // @desc:Distance of the password field/login button from the username.

    // [LoginScreen.LoginArea.LoginButton]
    property color loginButtonBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/background-color") || "#FFFFFF" // @desc:Background color of the login button.
    property real loginButtonBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the login button.
    property color loginButtonActiveBackgroundColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-background-color") || "#FFFFFF" // @desc:Background color of the login button when hovered/focused.
    property real loginButtonActiveBackgroundOpacity: config.realValue("LoginScreen.LoginArea.LoginButton/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the login button when hovered/focused.
    property string loginButtonIcon: config.stringValue("LoginScreen.LoginArea.LoginButton/icon") || "arrow-right.png" // @possible:File in `icons/` @desc:Icon in the login button
    property int loginButtonIconSize: config.intValue("LoginScreen.LoginArea.LoginButton/icon-size") || 18 // @desc:Size of the icon in the login button.
    property color loginButtonContentColor: config.stringValue("LoginScreen.LoginArea.LoginButton/content-color") || "#FFFFFF" // @desc:Color of the icon/text in the login button.
    property color loginButtonActiveContentColor: config.stringValue("LoginScreen.LoginArea.LoginButton/active-content-color") || "#FFFFFF" // @desc:Color of the icon/text in the login button when hovered/focused.
    property int loginButtonBorderSize: config.intValue("LoginScreen.LoginArea.LoginButton/border-size") // @desc:Border size of the login button.
    property color loginButtonBorderColor: config.stringValue("LoginScreen.LoginArea.LoginButton/border-color") || "#FFFFFF" // @desc:Border color of the login button.
    property int loginButtonBorderRadiusLeft: config.intValue("LoginScreen.LoginArea.LoginButton/border-radius-left") // @desc:Left border radius of the login button.
    property int loginButtonBorderRadiusRight: config.intValue("LoginScreen.LoginArea.LoginButton/border-radius-right") // @desc:Right border radius of the login button.
    property int loginButtonMarginLeft: config.intValue("LoginScreen.LoginArea.LoginButton/margin-left") // @desc:Distance of the login button from the password field.
    property bool loginButtonShowTextIfNoPassword: config['LoginScreen.LoginArea.LoginButton/show-text-if-no-password'] === "false" ? false : true // @desc:Whether or not to show a label in the login button when the password field is not visible.
    property bool loginButtonHideIfNotNeeded: config.boolValue("LoginScreen.LoginArea.LoginButton/hide-if-not-needed") // @desc:Whether or not to hide the login button if the password field is visible. You can still log-in with [enter].
    property string loginButtonFontFamily: config.stringValue("LoginScreen.LoginArea.LoginButton/font-family") || "RedHatDisplay" // @desc:Font family of the label of the login button/
    property int loginButtonFontSize: config.intValue("LoginScreen.LoginArea.LoginButton/font-size") || 12 // @desc:Font size of the label of the login button.
    property int loginButtonFontWeight: config.intValue("LoginScreen.LoginArea.LoginButton/font-weight") || 600 // @desc:Font weight of the label of the login button. 400 = regular, 600 = bold, 800 = black

    // [LoginScreen.LoginArea.Spinner]
    property bool spinnerDisplayText: config['LoginScreen.LoginArea.Spinner/display-text'] === "false" ? false : true // @desc:Whether or not to display the text with the spinning icon.
    property string spinnerText: config.stringValue("LoginScreen.LoginArea.Spinner/text") || textConstants.authenticating || "Logging in" // @desc:Text to be displayed with the spinning icon.
    property string spinnerFontFamily: config.stringValue("LoginScreen.LoginArea.Spinner/font-family") || "RedHatDisplay" // @desc:Font family of the text to be displayed with the spinning icon.
    property int spinnerFontWeight: config.intValue("LoginScreen.LoginArea.Spinner/font-weight") || 600 // @desc:Font weight of the text to be displayed with the spinning icon. 400 = regular, 600 = bold, 800 = black
    property int spinnerFontSize: config.intValue("LoginScreen.LoginArea.Spinner/font-size") || 12 // @desc:Font size of the spinner's text.
    property int spinnerIconSize: config.intValue("LoginScreen.LoginArea.Spinner/icon-size") || 32 // @desc:Size of the spinning icon.
    property string spinnerIcon: config.stringValue("LoginScreen.LoginArea.Spinner/icon") || "spinner.svg" // @possible:File in `icons/` @desc:Spinning icon.
    property color spinnerColor: config.stringValue("LoginScreen.LoginArea.Spinner/color") || "#FFFFFF" // @desc:Color of the spinning icon and its text.
    property int spinnerSpacing: config.intValue("LoginScreen.LoginArea.Spinner/spacing") // @desc:Spacing between the spinning icon and its text.

    // [LoginScreen.LoginArea.WarningMessage]
    property string warningMessageFontFamily: config.stringValue("LoginScreen.LoginArea.WarningMessage/font-family") || "RedHatDisplay" // @desc:Font family of the warning message.
    property int warningMessageFontSize: config.intValue("LoginScreen.LoginArea.WarningMessage/font-size") || 11 // @desc:Font size of the warning message.
    property int warningMessageFontWeight: config.intValue("LoginScreen.LoginArea.WarningMessage/font-weight") || 400 // @desc:Font weight of the warning message. 400 = regular, 600 = bold, 800 = black
    property color warningMessageNormalColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/normal-color") || "#FFFFFF" // @desc:Color of the warning message for normal messages.
    property color warningMessageWarningColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/warning-color") || "#FFFFFF" // @desc:Color of the warning message for warnings.
    property color warningMessageErrorColor: config.stringValue("LoginScreen.LoginArea.WarningMessage/error-color") || "#FFFFFF" // @desc:Color of the warning message for error messages.
    property int warningMessageMarginTop: config.intValue("LoginScreen.LoginArea.WarningMessage/margin-top") // @desc:Distance of the warning message from the password field/login button.

    // [LoginScreen.MenuArea.Buttons]
    property int menuAreaButtonsMarginTop: config.intValue("LoginScreen.MenuArea.Buttons/margin-top") // @desc:Top margin of the menu buttons.
    property int menuAreaButtonsMarginRight: config.intValue("LoginScreen.MenuArea.Buttons/margin-right")  // @desc:Right margin of the menu buttons.
    property int menuAreaButtonsMarginBottom: config.intValue("LoginScreen.MenuArea.Buttons/margin-bottom") // @desc:Bottom margin of the menu buttons.
    property int menuAreaButtonsMarginLeft: config.intValue("LoginScreen.MenuArea.Buttons/margin-left") // @desc:Left margin of the menu buttons.
    property int menuAreaButtonsSize: config.intValue("LoginScreen.MenuArea.Buttons/size") || 30 // @desc:Size of the menu buttons.
    property int menuAreaButtonsBorderRadius: config.intValue("LoginScreen.MenuArea.Buttons/border-radius") // @desc:Border radius of the menu buttons.
    property int menuAreaButtonsSpacing: config.intValue("LoginScreen.MenuArea.Buttons/spacing") // @desc:Spacing between menu buttons placed in the same position.
    property string menuAreaButtonsFontFamily: config.stringValue("LoginScreen.MenuArea.Buttons/font-family") || "RedHatDisplay" // @desc:Font family of the menu buttons.

    // [LoginScreen.MenuArea.Popups]
    property int menuAreaPopupsMaxHeight: config.intValue("LoginScreen.MenuArea.Popups/max-height") || 300 // @desc:Max height of the popups.
    property int menuAreaPopupsItemHeight: config.intValue("LoginScreen.MenuArea.Popups/item-height") || 30 // @desc:Height of the items inside a popup.
    property int menuAreaPopupsSpacing: config.intValue("LoginScreen.MenuArea.Popups/item-spacing") // @desc:Spacing between items inside a popup.
    property int menuAreaPopupsPadding: config.intValue("LoginScreen.MenuArea.Popups/padding") // @desc:Padding of the popups.
    property bool menuAreaPopupsDisplayScrollbar: config["LoginScreen.MenuArea.Popups/display-scrollbar"] === "false" ? false : true // @desc:Whether or not to display a scrollbar in the popups if its items don't fit.
    property int menuAreaPopupsMargin: config.intValue("LoginScreen.MenuArea.Popups/margin") || 5 // @desc:Distance of the popup from its button.
    property color menuAreaPopupsBackgroundColor: config.stringValue("LoginScreen.MenuArea.Popups/background-color") || "#FFFFFF" // @desc:Background color of the popups.
    property real menuAreaPopupsBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Popups/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the popups.
    property color menuAreaPopupsActiveOptionBackgroundColor: config.stringValue("LoginScreen.MenuArea.Popups/active-option-background-color") || "#FFFFFF" // @desc:Background color of the hovered/focused item in the popup.
    property real menuAreaPopupsActiveOptionBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Popups/active-option-background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the hovered/focused item in the popup.
    property color menuAreaPopupsContentColor: config.stringValue("LoginScreen.MenuArea.Popups/content-color") || "#FFFFFF" // @desc:Color of the text of the non-selected items in the popup.
    property color menuAreaPopupsActiveContentColor: config.stringValue("LoginScreen.MenuArea.Popups/active-content-color") || "#FFFFFF" // @desc:Color of the text of the hovered/focused item in the popup.
    property string menuAreaPopupsFontFamily: config.stringValue("LoginScreen.MenuArea.Popups/font-family") || "RedHatDisplay" // @desc:Font family of the popups.
    property int menuAreaPopupsBorderSize: config.intValue("LoginScreen.MenuArea.Popups/border-size") // @desc:Size of the border of the popups.
    property color menuAreaPopupsBorderColor: config.stringValue("LoginScreen.MenuArea.Popups/border-color") || "#FFFFFF" // @desc:Color of the border of the popups.
    property int menuAreaPopupsFontSize: config.intValue("LoginScreen.MenuArea.Popups/font-size") || 11 // @desc:Font size of the popups.
    property int menuAreaPopupsIconSize: config.intValue("LoginScreen.MenuArea.Popups/icon-size") || 16 // @desc:Size of the icons in the popups.

    // [LoginScreen.MenuArea.Session]
    property bool sessionDisplay: config["LoginScreen.MenuArea.Session/display"] === "false" ? false : true // @desc:Whether or not to display the session button.
    property string sessionPosition: config.stringValue("LoginScreen.MenuArea.Session/position") // @possible:'top-left' | 'top-center' | 'top-right' | 'center-left' | 'center-right' | 'bottom-left' | 'bottom-center' | 'bottom-right' @default:bottom-left @desc:Position of the session button.
    property int sessionIndex: config.intValue("LoginScreen.MenuArea.Session/index") // @default:0 @desc:This number is used to sort menu buttons placed in the same position.
    property string sessionPopupDirection: config.stringValue("LoginScreen.MenuArea.Session/popup-direction") || "up" // @possible:'up' | 'down' | 'left' | 'right' @desc:Which direction to open the session popup to.
    property string sessionPopupAlign: config.stringValue("LoginScreen.MenuArea.Session/popup-align") || "center" // @possible:'start' | 'center' | 'end' // @desc:Alignment of the session popup.
    property bool sessionDisplaySessionName: config['LoginScreen.MenuArea.Session/display-session-name'] === "false" ? false : true // @desc:Whether or not to display the name of the current session in the session button.
    property int sessionButtonWidth: config.intValue("LoginScreen.MenuArea.Session/button-width") || 200 // @desc:Width of the session button. Set this to '-1' to make it the same as its contents. <br/>This option is not applied if 'display-session-name' is set to true.
    property int sessionPopupWidth: config.intValue("LoginScreen.MenuArea.Session/popup-width") || 200 // @desc:Width of the session popup.
    property color sessionBackgroundColor: config.stringValue("LoginScreen.MenuArea.Session/background-color") || "#FFFFFF" // @desc:Background color of the session button.
    property real sessionBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the session button.
    property real sessionActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Session/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the session button when hovered/focused.
    property color sessionContentColor: config.stringValue("LoginScreen.MenuArea.Session/content-color") || "#FFFFFF" // @desc:Color of the icon and text in the session button.
    property color sessionActiveContentColor: config.stringValue("LoginScreen.MenuArea.Session/active-content-color") || "#FFFFFF" // @desc:Color of the icon and text in the session button when hovered/focused.
    property int sessionBorderSize: config.intValue("LoginScreen.MenuArea.Session/border-size") // @desc:Size of the border of the session button. The color of the border is defined by 'content-color' and 'active-content-color'.
    property int sessionFontSize: config.intValue("LoginScreen.MenuArea.Session/font-size") || 10 // @desc:Font size of the session button.
    property int sessionIconSize: config.intValue("LoginScreen.MenuArea.Session/icon-size") || 16 // @desc:Size of the icon in the session button.

    // [LoginScreen.MenuArea.Layout]
    property bool layoutDisplay: config["LoginScreen.MenuArea.Layout/display"] === "false" ? false : true // @desc:Whether or not to display the layout button.
    property string layoutPosition: config.stringValue("LoginScreen.MenuArea.Layout/position") // @possible:'top-left' | 'top-center' | 'top-right' | 'center-left' | 'center-right' | 'bottom-left' | 'bottom-center' | 'bottom-right' @default:bottom-right @desc:Position of the layout button.
    property int layoutIndex: config.intValue("LoginScreen.MenuArea.Layout/index") // @default:1 @desc:This number is used to sort menu buttons placed in the same position.
    property string layoutPopupDirection: config.stringValue("LoginScreen.MenuArea.Layout/popup-direction") || "up" // @possible:'up' | 'down' | 'left' | 'right' @desc:Which direction to open the layout popup to.
    property string layoutPopupAlign: config.stringValue("LoginScreen.MenuArea.Layout/popup-align") || "center" // @possible:'start' | 'center' | 'end' @desc:Alignment of the session popup.
    property int layoutPopupWidth: config.intValue("LoginScreen.MenuArea.Layout/popup-width") || 180 // @desc:Width of the layout popup.
    property bool layoutDisplayLayoutName: config['LoginScreen.MenuArea.Layout/display-layout-name'] === "false" ? false : true // @desc:Whether or not to display the country code of the current layout in the layout button.
    property color layoutBackgroundColor: config.stringValue("LoginScreen.MenuArea.Layout/background-color") || "#FFFFFF" // @desc:Background color of the layout button.
    property real layoutBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Layout/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the layout button.
    property real layoutActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Layout/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the layout button when hovered/focused.
    property color layoutContentColor: config.stringValue("LoginScreen.MenuArea.Layout/content-color") || "#FFFFFF" // @desc:Color of the icon and text in the layout button.
    property color layoutActiveContentColor: config.stringValue("LoginScreen.MenuArea.Layout/active-content-color") || "#FFFFFF" // @desc:Color of the icon and text in the layout button when hovered/focused.
    property int layoutBorderSize: config.intValue("LoginScreen.MenuArea.Layout/border-size") // @desc:Size of the border of the layouts button. The color of the border is defined by 'content-color' and 'active-content-color'.
    property int layoutFontSize: config.intValue("LoginScreen.MenuArea.Layout/font-size") || 10 // @desc:Font size of the layout button.
    property string layoutIcon: config.stringValue("LoginScreen.MenuArea.Layout/icon") || "language.svg" // @possible:File in `icons/` @desc:Icon in the layout button.
    property int layoutIconSize: config.intValue("LoginScreen.MenuArea.Layout/icon-size") || 16 // @desc:Size of the icon in the layout button.

    // [LoginScreen.MenuArea.Keyboard]
    property bool keyboardDisplay: config["LoginScreen.MenuArea.Keyboard/display"] === "false" ? false : true // @desc:Whether or not to display the virtual keyboard toggle button.
    property string keyboardPosition: config.stringValue("LoginScreen.MenuArea.Keyboard/position") // @possible:'top-left' | 'top-center' | 'top-right' | 'center-left' | 'center-right' | 'bottom-left' | 'bottom-center' | 'bottom-right' @default:bottom-right @desc:Position of the virtual keyboard toggle button.
    property int keyboardIndex: config.intValue("LoginScreen.MenuArea.Keyboard/index") // @default:2 @desc:This number is used to sort menu buttons placed in the same position.
    property color keyboardBackgroundColor: config.stringValue("LoginScreen.MenuArea.Keyboard/background-color") || "#FFFFFF" // @desc:Background color of the virtual keyboard toggle button.
    property real keyboardBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Keyboard/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the virtual keyboard toggle button
    property real keyboardActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Keyboard/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the virtual keyboard toggle button when hovered/focused.
    property color keyboardContentColor: config.stringValue("LoginScreen.MenuArea.Keyboard/content-color") || "#FFFFFF" // @desc:Color of the icon in the virtual keyboard toggle button.
    property color keyboardActiveContentColor: config.stringValue("LoginScreen.MenuArea.Keyboard/active-content-color") || "#FFFFFF" // @desc:Color of the icon in the virtual keyboard toggle button when hovered/focused.
    property int keyboardBorderSize: config.intValue("LoginScreen.MenuArea.Keyboard/border-size") // @desc:Border size of the virtual keyboard toggle button. The color of the border is defined by 'content-color' and 'active-content-color'.
    property string keyboardIcon: config.stringValue("LoginScreen.MenuArea.Keyboard/icon") || "keyboard.svg" // @possible:File in `icons/` @desc:Icon in the virtual keyboard toggle button.
    property int keyboardIconSize: config.intValue("LoginScreen.MenuArea.Keyboard/icon-size") || 16 // @desc:Size of the icon in the virtual keyboard toggle button.

    // [LoginScreen.MenuArea.Power]
    property bool powerDisplay: config["LoginScreen.MenuArea.Power/display"] === "false" ? false : true // @desc:Whether or not to display the power button.
    property string powerPosition: config.stringValue("LoginScreen.MenuArea.Power/position") // @possible:'top-left' | 'top-center' | 'top-right' | 'center-left' | 'center-right' | 'bottom-left' | 'bottom-center' | 'bottom-right' @default:bottom-right @desc:Position of the power button.
    property int powerIndex: config.intValue("LoginScreen.MenuArea.Power/index") // @default:3 @desc:This number is used to sort menu buttons placed in the same position.
    property string powerPopupDirection: config.stringValue("LoginScreen.MenuArea.Power/popup-direction") || "up" // @possible:'up' | 'down' | 'left' | 'right' @desc:Which direction to open the power popup to.
    property string powerPopupAlign: config.stringValue("LoginScreen.MenuArea.Power/popup-align") || "center" // @possible:'start' | 'center' | 'end' @Alignment of the power popup.
    property int powerPopupWidth: config.intValue("LoginScreen.MenuArea.Power/popup-width") || 90 // @desc:Width of the power popup.
    property color powerBackgroundColor: config.stringValue("LoginScreen.MenuArea.Power/background-color") || "#FFFFFF" // @desc:Background color of the power button.
    property real powerBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Power/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the power button.
    property real powerActiveBackgroundOpacity: config.realValue("LoginScreen.MenuArea.Power/active-background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the power button when hovered/focused.
    property color powerContentColor: config.stringValue("LoginScreen.MenuArea.Power/content-color") || "#FFFFFF" // @desc:Color of the icon in the power button.
    property color powerActiveContentColor: config.stringValue("LoginScreen.MenuArea.Power/active-content-color") || "#FFFFFF" // @desc:Color of the icon in the power button when hovered/focused.
    property int powerBorderSize: config.intValue("LoginScreen.MenuArea.Power/border-size") // @desc:Border size of the power button. The color of the border is defined by 'content-color' and 'active-content-color'.
    property string powerIcon: config.stringValue("LoginScreen.MenuArea.Power/icon") || "power.svg" // @possible:File in `icons/` @desc:Icon in the power button.
    property int powerIconSize: config.intValue("LoginScreen.MenuArea.Power/icon-size") || 16 // @desc:Size of the icon in the power button.

    // [LoginScreen.VirtualKeyboard]
    property int virtualKeyboardScale: config.realValue("LoginScreen.VirtualKeyboard/scale") || 1.0 // @desc:Scale of the virtual keyboard.
    property string virtualKeyboardPosition: config.stringValue("LoginScreen.VirtualKeyboard/position") || "login" // @possible: 'login' | 'top' | 'bottom' | 'left' | 'right' @desc:Initial position of the virtual keyboard. You can drag the keyboard using the middle mouse button.
    property bool virtualKeyboardStartHidden: config['LoginScreen.VirtualKeyboard/start-hidden'] === "false" ? false : true // @desc:Whether or not the virtual keyboard should start hidden.
    property color virtualKeyboardBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/background-color") || "#FFFFFF" // @desc:Color of the background of the virtual keyboard.
    property real virtualKeyboardBackgroundOpacity: config.realValue("LoginScreen.VirtualKeyboard/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the virtual keyboard.
    property color virtualKeyboardKeyContentColor: config.stringValue("LoginScreen.VirtualKeyboard/key-content-color") || "#FFFFFF" // @desc:Color of the keys' text/icon in the virtual keyboard.
    property color virtualKeyboardKeyColor: config.stringValue("LoginScreen.VirtualKeyboard/key-color") || "#FFFFFF" // @desc:Color of the background of the keys in the virtual keyboard.
    property real virtualKeyboardKeyOpacity: config.realValue("LoginScreen.VirtualKeyboard/key-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the keys in the virtual keybaord.
    property color virtualKeyboardKeyActiveBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/key-active-background-color") || "#FFFFFF" // @desc:Color of the background of the special keys in the virtual keyboard.
    property real virtualKeyboardKeyActiveOpacity: config.realValue("LoginScreen.VirtualKeyboard/key-active-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the special keys in the virtual keyboard.
    property color virtualKeyboardSelectionBackgroundColor: config.stringValue("LoginScreen.VirtualKeyboard/selection-background-color") || "#CCCCCC" // @desc:Color of the background of the selected character in the virtual keyboard.
    property color virtualKeyboardSelectionContentColor: config.stringValue("LoginScreen.VirtualKeyboard/selection-content-color") || "#FFFFFF" // @desc:Color of the text of the selected character in the virtual keyboard.
    property color virtualKeyboardPrimaryColor: config.stringValue("LoginScreen.VirtualKeyboard/primary-color") || "#000000" // @desc:Color of the icon/text in special keys when they're active.
    property int virtualKeyboardBorderSize: config.realValue("LoginScreen.VirtualKeyboard/border-size") // @desc:Border size of the virtual keyboard and its keys.
    property color virtualKeyboardBorderColor: config.stringValue("LoginScreen.VirtualKeyboard/border-color") || "#000000" // @desc:Color of the border of the virtual keyboard and its keys.

    // [Tooltips]
    property bool tooltipsEnable: config['Tooltips/enable'] === "false" ? false : true // @desc:Whether or not to show tooltips when hovering over buttons.
    property string tooltipsFontFamily: config.stringValue("Tooltips/font-family") || "RedHatDisplay" // @desc:Font family of the tooltips.
    property int tooltipsFontSize: config.intValue("Tooltips/font-size") || 11 // @desc:Font size of the tooltips.
    property color tooltipsContentColor: config.stringValue("Tooltips/content-color") || "#FFFFFF" // @desc:Color of the text in tooltips.
    property color tooltipsBackgroundColor: config.stringValue("Tooltips/background-color") || "#FFFFFF" // @desc:Color of the background of the tooltips.
    property real tooltipsBackgroundOpacity: config.realValue("Tooltips/background-opacity") // @possible:0.0 ≤ R ≤ 1.0 @desc:Opacity of the background of the tooltips.
    property int tooltipsBorderRadius: config.intValue("Tooltips/border-radius") || 5 // @desc:Border radius of the tooltips.
    property bool tooltipsDisableUser: config.boolValue("Tooltips/disable-user") // @desc:If false, disables only the tooltip for the user selector.
    property bool tooltipsDisableLoginButton: config.boolValue("Tooltips/disable-login-button") // @desc:If false, disabled only the tooltip for the login button.
    property bool tooltipsDisableSessionButton: config.boolValue("Tooltips/disable-session-button") // @desc:If false, disables only the tooltip for the session button.
    property bool tooltipsDisableLayoutButton: config.boolValue("Tooltips/disable-layout-button") // @desc:If false, disables only the tooltip for the layout button.
    property bool tooltipsDisableKeyboardButton: config.boolValue("Tooltips/disable-keyboard-button") // @desc:If false, disables only the tooltip for the keyboard button.
    property bool tooltipsDisablePowerButton: config.boolValue("Tooltips/disable-power-button") // @desc:If false, disables only the tooltip for the power button.

    function sortMenuButtons() {
        const menus = [];
        const available_positions = ["top-left", "top-center", "top-right", "center-left", "center-right", "bottom-left", "bottom-center", "bottom-right"];

        if (sessionDisplay)
            menus.push({
                name: "session",
                index: sessionIndex,
                def_index: 0,
                position: available_positions.includes(sessionPosition) ? sessionPosition : "bottom-left"
            });

        if (layoutDisplay)
            menus.push({
                name: "layout",
                index: layoutIndex,
                def_index: 1,
                position: available_positions.includes(layoutPosition) ? layoutPosition : "bottom-right"
            });

        if (keyboardDisplay)
            menus.push({
                name: "keyboard",
                index: keyboardIndex,
                def_index: 2,
                position: available_positions.includes(keyboardPosition) ? keyboardPosition : "bottom-right"
            });

        if (powerDisplay)
            menus.push({
                name: "power",
                index: powerIndex,
                def_index: 3,
                position: available_positions.includes(powerPosition) ? powerPosition : "bottom-right"
            });

        // Sort by index or default index if 0
        return menus.sort((c, n) => c.index - n.index || c.def_index - n.def_index);
    }

    function getIcon(iconName) {
        return `../icons/${iconName}`;
    }
}
