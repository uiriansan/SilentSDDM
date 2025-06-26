// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

// Taken from https://github.com/qt/qtvirtualkeyboard/blob/16fbddbbc03777e0a006daa998eda14624d62268/src/styles/builtin/default/style.qml#L11

import QtQuick
import QtQuick.Effects
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Styles
import "../../../../../components"

KeyboardStyle {
    id: vkeyboardStyle

    readonly property bool compactSelectionList: [InputEngine.InputMode.Pinyin, InputEngine.InputMode.Cangjie, InputEngine.InputMode.Zhuyin].indexOf(InputContext.inputEngine.inputMode) !== -1
    readonly property string fontFamily: Config.menuAreaButtonsFontFamily
    readonly property real keyBackgroundMargin: Math.round(8 * scaleHint)
    readonly property real keyContentMargin: Math.round(40 * scaleHint)
    readonly property real keyIconScale: scaleHint * 0.8
    readonly property string resourcePrefix: "../../../../../icons/"

    readonly property string inputLocale: InputContext.locale
    property color primaryColor: Config.virtualKeyboardPrimaryColor
    property color primaryLightColor: Config.virtualKeyboardKeyActiveBackgroundColor
    property color primaryDarkColor: Config.virtualKeyboardKeyColor
    property color textOnPrimaryColor: Config.virtualKeyboardKeyContentColor
    property color secondaryColor: Config.virtualKeyboardSelectionBackgroundColor
    property color secondaryLightColor: Config.virtualKeyboardPrimaryColor
    property color secondaryDarkColor: Config.virtualKeyboardPrimaryColor
    property color textOnSecondaryColor: Config.virtualKeyboardSelectionContentColor

    property color normalKeyBackgroundColor: primaryDarkColor
    property color highlightedKeyBackgroundColor: primaryLightColor
    property real highlightedKeyBackgroundOpacity: Config.virtualKeyboardKeyActiveOpacity
    property real normalKeyBackgroundOpacity: Config.virtualKeyboardKeyOpacity
    property color capsLockKeyAccentColor: secondaryColor
    property color modeKeyAccentColor: textOnPrimaryColor
    property color keyTextColor: textOnPrimaryColor
    property color keySmallTextColor: textOnPrimaryColor
    property color popupBackgroundColor: secondaryColor
    property color popupBorderColor: secondaryLightColor
    property color popupTextColor: textOnSecondaryColor
    property color popupHighlightColor: secondaryLightColor
    property color selectionListTextColor: textOnPrimaryColor
    property color selectionListSeparatorColor: primaryLightColor
    property color selectionListBackgroundColor: primaryColor
    property color navigationHighlightColor: primaryColor

    property real inputLocaleIndicatorOpacity: 1.0
    property Timer inputLocaleIndicatorHighlightTimer: Timer {
        interval: 1000
        onTriggered: inputLocaleIndicatorOpacity = 0.5
    }
    onInputLocaleChanged: {
        inputLocaleIndicatorOpacity = 1.0;
        inputLocaleIndicatorHighlightTimer.restart();
    }

    Component.onDestruction: {
        if (inputLocaleIndicatorHighlightTimer) {
            inputLocaleIndicatorHighlightTimer.running = false;
            inputLocaleIndicatorHighlightTimer.stop();
        }
        if (traceInputGuideConnections) {
            traceInputGuideConnections.target = null;
        }
    }

    property Component component_settingsIcon: Component {
        Item {
            Image {
                id: settingsIcon
                sourceSize.width: 80 * keyIconScale
                sourceSize.height: 80 * keyIconScale
                smooth: false
                source: resourcePrefix + "settings.svg"
                visible: false
            }
            MultiEffect {
                id: settingsIconEffect
                source: settingsIcon
                anchors.fill: settingsIcon
                colorization: 1
                colorizationColor: vkeyboardStyle.textOnPrimaryColor
            }
        }
    }

    keyboardDesignWidth: 2560
    keyboardDesignHeight: 800
    keyboardRelativeLeftMargin: 6 / keyboardDesignWidth
    keyboardRelativeRightMargin: 6 / keyboardDesignWidth
    keyboardRelativeTopMargin: 6 / keyboardDesignHeight
    keyboardRelativeBottomMargin: 6 / keyboardDesignHeight

    keyboardBackground: Rectangle {
        color: "transparent"
        border {
            width: Config.virtualKeyboardBorderSize
            color: Config.virtualKeyboardBorderColor
        }
        radius: 10

        Rectangle {
            z: parent.z - 1
            anchors.fill: parent
            color: Config.virtualKeyboardBackgroundColor
            opacity: Config.virtualKeyboardBackgroundOpacity
            radius: 10
        }
    }

    keyPanel: KeyPanel {
        id: keyPanel
        Rectangle {
            id: keyBackground
            radius: 5
            anchors.fill: keyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                id: keyBg
                anchors.fill: parent
                radius: 5
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Text {
                id: keySmallText
                text: control.smallText
                visible: control.smallTextVisible
                color: keySmallTextColor
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: keyContentMargin / 3
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 60 * scaleHint
                    capitalization: control.uppercased ? Font.AllUppercase : Font.MixedCase
                }
            }
            Loader {
                id: loader_settingsIcon
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: keyContentMargin / 3
            }
            Text {
                id: keyText
                text: control.displayText
                color: keyTextColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: control.displayText.length > 1 ? Text.AlignVCenter : Text.AlignBottom
                anchors.fill: parent
                anchors.leftMargin: keyContentMargin
                anchors.topMargin: keyContentMargin
                anchors.rightMargin: keyContentMargin
                anchors.bottomMargin: keyContentMargin
                font {
                    family: fontFamily
                    weight: Font.Bold
                    pixelSize: 60 * scaleHint
                    capitalization: control.uppercased ? Font.AllUppercase : Font.MixedCase
                }
            }
            states: [
                State {
                    when: control.smallText === "\u2699" && control.smallTextVisible
                    PropertyChanges {
                        target: keySmallText
                        visible: false
                    }
                    PropertyChanges {
                        target: loader_settingsIcon
                        sourceComponent: component_settingsIcon
                    }
                }
            ]
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: keyBg
                    opacity: 0.35
                }
                PropertyChanges {
                    target: keyText
                    opacity: 0.15
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: keyBg
                    opacity: 0.35
                }
                PropertyChanges {
                    target: keyText
                    opacity: 0.05
                }
            }
        ]
    }

    backspaceKeyPanel: KeyPanel {
        id: backspaceKeyPanel
        Rectangle {
            id: backspaceKeyBackground
            radius: 5
            anchors.fill: backspaceKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Image {
                id: backspaceKeyIcon
                anchors.centerIn: parent
                sourceSize.height: 100 * keyIconScale
                smooth: false
                source: resourcePrefix + "backspace.svg"
                visible: false
            }
            MultiEffect {
                id: backspaceIconEffect
                source: backspaceKeyIcon
                anchors.fill: backspaceKeyIcon
                colorization: 1
                colorizationColor: vkeyboardStyle.textOnPrimaryColor
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: backspaceKeyBackground
                    opacity: 0.80
                }
                PropertyChanges {
                    target: backspaceKeyIcon
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: backspaceKeyBackground
                    opacity: 0.8
                }
                PropertyChanges {
                    target: backspaceKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    languageKeyPanel: KeyPanel {
        id: languageKeyPanel
        Rectangle {
            id: languageKeyBackground
            radius: 5
            anchors.fill: languageKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Image {
                id: languageKeyIcon
                anchors.centerIn: parent
                sourceSize.height: 100 * keyIconScale
                smooth: false
                source: resourcePrefix + "language.svg"
                visible: false
            }
            MultiEffect {
                id: languageIconEffect
                source: languageKeyIcon
                anchors.fill: languageKeyIcon
                colorization: 1
                colorizationColor: vkeyboardStyle.textOnPrimaryColor
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: languageKeyBackground
                    opacity: 0.80
                }
                PropertyChanges {
                    target: languageKeyIcon
                    opacity: 0.75
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: languageKeyBackground
                    opacity: 0.8
                }
                PropertyChanges {
                    target: languageKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    enterKeyPanel: KeyPanel {
        id: enterKeyPanel
        Rectangle {
            id: enterKeyBackground
            radius: 5
            anchors.fill: enterKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Image {
                id: enterKeyIcon
                anchors.centerIn: parent
                readonly property size enterKeyIconSize: {
                    switch (control.actionId) {
                    case EnterKeyAction.Go:
                    case EnterKeyAction.Send:
                    case EnterKeyAction.Next:
                    case EnterKeyAction.Done:
                        return Qt.size(170, 119);
                    case EnterKeyAction.Search:
                        return Qt.size(148, 148);
                    default:
                        return Qt.size(211, 80);
                    }
                }
                sourceSize.height: enterKeyIconSize.height * keyIconScale
                smooth: false
                source: {
                    switch (control.actionId) {
                    case EnterKeyAction.Go:
                    case EnterKeyAction.Send:
                    case EnterKeyAction.Next:
                    case EnterKeyAction.Done:
                        return resourcePrefix + "check.svg";
                    case EnterKeyAction.Search:
                        return resourcePrefix + "search.svg";
                    default:
                        return resourcePrefix + "enter-key.svg";
                    }
                }
                visible: false
            }
            MultiEffect {
                id: enterIconEffect
                source: enterKeyIcon
                anchors.fill: enterKeyIcon
                colorization: 1
                visible: enterKeyText.text.length === 0
                colorizationColor: vkeyboardStyle.textOnPrimaryColor
            }
            Text {
                id: enterKeyText
                visible: text.length !== 0
                text: control.actionId !== EnterKeyAction.None ? control.displayText : ""
                clip: true
                fontSizeMode: Text.HorizontalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: keyTextColor
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 50 * scaleHint
                    capitalization: Font.AllUppercase
                }
                anchors.fill: parent
                anchors.margins: Math.round(42 * scaleHint)
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: enterKeyBackground
                    opacity: 0.80
                }
                PropertyChanges {
                    target: enterKeyIcon
                    opacity: 0.6
                }
                PropertyChanges {
                    target: enterKeyText
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: enterKeyBackground
                    opacity: 0.8
                }
                PropertyChanges {
                    target: enterKeyIcon
                    opacity: 0.2
                }
                PropertyChanges {
                    target: enterKeyText
                    opacity: 0.2
                }
            }
        ]
    }

    hideKeyPanel: KeyPanel {
        id: hideKeyPanel
        Rectangle {
            id: hideKeyBackground
            radius: 5
            anchors.fill: hideKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Image {
                id: hideKeyIcon
                anchors.centerIn: parent
                sourceSize.height: 127 * keyIconScale
                smooth: false
                source: resourcePrefix + "hidekeyboard.svg"

                MultiEffect {
                    id: hideIconEffect
                    source: parent
                    anchors.fill: parent
                    colorization: 1
                    colorizationColor: vkeyboardStyle.textOnPrimaryColor
                }
            }

            MouseArea {
                // Close virtual keyboard
                anchors.fill: parent
                onClicked: loginScreen.showKeyboard = false
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: hideKeyBackground
                    opacity: 0.80
                }
                PropertyChanges {
                    target: hideKeyIcon
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: hideKeyBackground
                    opacity: 0.8
                }
                PropertyChanges {
                    target: hideKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    shiftKeyPanel: KeyPanel {
        id: shiftKeyPanel
        Rectangle {
            id: shiftKeyBackground
            radius: 5
            anchors.fill: shiftKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Image {
                id: shiftKeyIcon
                anchors.centerIn: parent
                sourceSize.height: 100 * keyIconScale
                smooth: false
                source: resourcePrefix + "shift.svg"
                visible: false
            }
            MultiEffect {
                id: shiftKeyColor
                source: shiftKeyIcon
                anchors.fill: shiftKeyIcon
                colorization: 1
                colorizationColor: vkeyboardStyle.textOnPrimaryColor
            }
            states: [
                State {
                    name: "capsLockActive"
                    when: InputContext.capsLockActive
                    PropertyChanges {
                        target: shiftKeyBackground
                        color: capsLockKeyAccentColor
                    }
                    PropertyChanges {
                        target: shiftKeyIcon
                        source: resourcePrefix + "shift-upper.svg"
                    }
                    PropertyChanges {
                        target: shiftKeyColor
                        colorizationColor: primaryColor
                    }
                },
                State {
                    name: "shiftActive"
                    when: InputContext.shiftActive
                    PropertyChanges {
                        target: shiftKeyIcon
                        source: resourcePrefix + "shift-fill.svg"
                    }
                    PropertyChanges {
                        target: shiftKeyColor
                        colorizationColor: primaryColor
                    }
                }
            ]
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: shiftKeyBackground
                    opacity: 0.80
                }
                PropertyChanges {
                    target: shiftKeyIcon
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: shiftKeyBackground
                    opacity: 0.8
                }
                PropertyChanges {
                    target: shiftKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    spaceKeyPanel: KeyPanel {
        id: spaceKeyPanel
        Rectangle {
            id: spaceKeyBackground
            radius: 5
            anchors.fill: spaceKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Text {
                id: spaceKeyText
                text: Qt.locale(InputContext.locale).nativeLanguageName
                color: keyTextColor
                opacity: inputLocaleIndicatorOpacity
                Behavior on opacity {
                    PropertyAnimation {
                        duration: 250
                    }
                }
                anchors.centerIn: parent
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 60 * scaleHint
                }
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: spaceKeyBackground
                    opacity: 0.80
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: spaceKeyBackground
                    opacity: 0.8
                }
            }
        ]
    }

    symbolKeyPanel: KeyPanel {
        id: symbolKeyPanel
        Rectangle {
            id: symbolKeyBackground
            radius: 5
            anchors.fill: symbolKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Text {
                id: symbolKeyText
                text: control.displayText
                color: keyTextColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                anchors.margins: keyContentMargin
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 60 * scaleHint
                    capitalization: Font.AllUppercase
                }
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: symbolKeyBackground
                    opacity: 0.80
                }
                PropertyChanges {
                    target: symbolKeyText
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: symbolKeyBackground
                    opacity: 0.8
                }
                PropertyChanges {
                    target: symbolKeyText
                    opacity: 0.2
                }
            }
        ]
    }

    modeKeyPanel: KeyPanel {
        id: modeKeyPanel
        Rectangle {
            id: modeKeyBackground
            radius: 5
            anchors.fill: modeKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Text {
                id: modeKeyText
                text: control.displayText
                color: keyTextColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                anchors.margins: keyContentMargin
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 60 * scaleHint
                    capitalization: Font.AllUppercase
                }
            }
            Rectangle {
                id: modeKeyIndicator
                implicitHeight: parent.height * 0.1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: parent.width * 0.4
                anchors.rightMargin: parent.width * 0.4
                anchors.bottomMargin: parent.height * 0.12
                color: modeKeyAccentColor
                radius: 3
                visible: control.mode
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: modeKeyBackground
                    opacity: 0.80
                }
                PropertyChanges {
                    target: modeKeyText
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: modeKeyBackground
                    opacity: 0.8
                }
                PropertyChanges {
                    target: modeKeyText
                    opacity: 0.2
                }
            }
        ]
    }

    handwritingKeyPanel: KeyPanel {
        id: handwritingKeyPanel
        Rectangle {
            id: hwrKeyBackground
            radius: 5
            anchors.fill: handwritingKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                visible: !(loginScreen && loginScreen.userNeedsPassword)
                enabled: visible
                hoverEnabled: enabled
            }

            Rectangle {
                anchors.fill: parent
                color: control && control.highlighted ? highlightedKeyBackgroundColor : normalKeyBackgroundColor
                opacity: control && control.highlighted ? highlightedKeyBackgroundOpacity : normalKeyBackgroundOpacity
                radius: 5
            }

            Rectangle {
                anchors.fill: parent
                visible: Config.virtualKeyboardBorderSize > 0
                color: "transparent"
                border {
                    width: Config.virtualKeyboardBorderSize
                    color: Config.virtualKeyboardBorderColor
                }
                radius: parent.radius
            }
            Image {
                id: hwrKeyIcon
                anchors.centerIn: parent
                sourceSize.height: 100 * keyIconScale
                smooth: false
                source: resourcePrefix + ((keyboard && keyboard.handwritingMode) ? "textmode.svg" : "handwriting.svg")
                visible: false
            }
            MultiEffect {
                id: hwrIconEffect
                source: hwrKeyIcon
                anchors.fill: hwrKeyIcon
                colorization: 1
                colorizationColor: vkeyboardStyle.textOnPrimaryColor
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: hwrKeyBackground
                    opacity: 0.80
                }
                PropertyChanges {
                    target: hwrKeyIcon
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: hwrKeyBackground
                    opacity: 0.8
                }
                PropertyChanges {
                    target: hwrKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    characterPreviewMargin: 0
    characterPreviewDelegate: Item {
        id: characterPreview
        property string text
        property string flickLeft
        property string flickTop
        property string flickRight
        property string flickBottom
        readonly property bool flickKeysSet: flickLeft || flickTop || flickRight || flickBottom
        readonly property bool flickKeysVisible: text && flickKeysSet && text !== flickLeft && text !== flickTop && text !== flickRight && text !== flickBottom
        Rectangle {
            id: characterPreviewBackground
            anchors.fill: parent
            color: popupBackgroundColor
            radius: 5
            readonly property int largeTextHeight: Math.round(height / 3 * 2)
            readonly property int smallTextHeight: Math.round(height / 3)
            readonly property int smallTextMargin: Math.round(3 * scaleHint)
            Text {
                id: characterPreviewText
                color: popupTextColor
                text: characterPreview.text
                fontSizeMode: Text.VerticalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                height: characterPreviewBackground.largeTextHeight
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 82 * scaleHint
                }
            }
            Text {
                color: popupTextColor
                text: characterPreview.flickLeft
                visible: characterPreview.flickKeysVisible
                opacity: 0.8
                fontSizeMode: Text.VerticalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: characterPreviewBackground.smallTextMargin
                anchors.verticalCenter: parent.verticalCenter
                height: characterPreviewBackground.smallTextHeight
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 62 * scaleHint
                }
            }
            Text {
                color: popupTextColor
                text: characterPreview.flickTop
                visible: characterPreview.flickKeysVisible
                opacity: 0.8
                fontSizeMode: Text.VerticalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.topMargin: characterPreviewBackground.smallTextMargin
                anchors.horizontalCenter: parent.horizontalCenter
                height: characterPreviewBackground.smallTextHeight
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 62 * scaleHint
                }
            }
            Text {
                color: popupTextColor
                text: characterPreview.flickRight
                visible: characterPreview.flickKeysVisible
                opacity: 0.8
                fontSizeMode: Text.VerticalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.right: parent.right
                anchors.rightMargin: characterPreviewBackground.smallTextMargin
                anchors.verticalCenter: parent.verticalCenter
                height: characterPreviewBackground.smallTextHeight
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 62 * scaleHint
                }
            }
            Text {
                color: popupTextColor
                text: characterPreview.flickBottom
                visible: characterPreview.flickKeysVisible
                opacity: 0.8
                fontSizeMode: Text.VerticalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: characterPreviewBackground.smallTextMargin
                anchors.horizontalCenter: parent.horizontalCenter
                height: characterPreviewBackground.smallTextHeight
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 62 * scaleHint
                }
            }
            states: State {
                name: "flickKeysVisible"
                when: characterPreview.flickKeysVisible
                PropertyChanges {
                    target: characterPreviewText
                    height: characterPreviewBackground.smallTextHeight
                }
            }
        }
    }

    alternateKeysListItemWidth: 120 * scaleHint
    alternateKeysListItemHeight: 170 * scaleHint
    alternateKeysListDelegate: Item {
        id: alternateKeysListItem
        width: alternateKeysListItemWidth
        height: alternateKeysListItemHeight
        Text {
            id: listItemText
            text: model.text
            color: popupTextColor
            opacity: 0.8
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: 60 * scaleHint
            }
            anchors.centerIn: parent
        }
        states: State {
            name: "current"
            when: alternateKeysListItem.ListView.isCurrentItem
            PropertyChanges {
                target: listItemText
                opacity: 1
            }
        }
    }
    alternateKeysListHighlight: Rectangle {
        color: popupHighlightColor
        radius: 5
    }
    alternateKeysListBackground: Item {
        Rectangle {
            readonly property real margin: 20 * scaleHint
            x: -margin
            y: -margin
            width: parent.width + 2 * margin
            height: parent.height + 2 * margin
            radius: 5
            color: popupBackgroundColor
            border {
                width: 1
                color: popupBorderColor
            }
        }
    }

    selectionListHeight: 85 * scaleHint
    selectionListDelegate: SelectionListItem {
        id: selectionListItem
        width: Math.round(selectionListLabel.width + selectionListLabel.anchors.leftMargin * 2)
        Text {
            id: selectionListLabel
            anchors.left: parent.left
            anchors.leftMargin: Math.round((compactSelectionList ? 50 : 140) * scaleHint)
            anchors.verticalCenter: parent.verticalCenter
            text: decorateText(display, wordCompletionLength)
            color: selectionListTextColor
            opacity: 0.9
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: 44 * scaleHint
            }
            function decorateText(text, wordCompletionLength) {
                if (wordCompletionLength > 0) {
                    return text.slice(0, -wordCompletionLength) + '<u>' + text.slice(-wordCompletionLength) + '</u>';
                }
                return text;
            }
        }
        Rectangle {
            id: selectionListSeparator
            width: 4 * scaleHint
            height: 36 * scaleHint
            radius: 2
            color: selectionListSeparatorColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.left
        }
        states: State {
            name: "current"
            when: selectionListItem.ListView.isCurrentItem
            PropertyChanges {
                target: selectionListLabel
                opacity: 1
            }
        }
    }
    selectionListBackground: Rectangle {
        color: selectionListBackgroundColor
        opacity: 0.0
    }
    selectionListAdd: Transition {
        NumberAnimation {
            property: "y"
            from: wordCandidateView.height
            duration: 200
        }
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 200
        }
    }
    selectionListRemove: Transition {
        NumberAnimation {
            property: "y"
            to: -wordCandidateView.height
            duration: 200
        }
        NumberAnimation {
            property: "opacity"
            to: 0
            duration: 200
        }
    }

    navigationHighlight: Rectangle {
        color: "transparent"
        border.color: navigationHighlightColor
        border.width: 5
    }

    traceInputKeyPanelDelegate: TraceInputKeyPanel {
        id: traceInputKeyPanel
        traceMargins: keyBackgroundMargin
        Rectangle {
            id: traceInputKeyPanelBackground
            radius: 5
            anchors.fill: traceInputKeyPanel
            anchors.margins: keyBackgroundMargin
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: normalKeyBackgroundColor
                opacity: normalKeyBackgroundOpacity
                radius: 5
            }
            Text {
                id: hwrInputModeIndicator
                visible: control.patternRecognitionMode === InputEngine.PatternRecognitionMode.Handwriting
                text: {
                    switch (InputContext.inputEngine.inputMode) {
                    case InputEngine.InputMode.Numeric:
                        if (["ar", "fa"].indexOf(InputContext.locale.substring(0, 2)) !== -1)
                            return "\u0660\u0661\u0662";
                    // Fallthrough
                    case InputEngine.InputMode.Dialable:
                        return "123";
                    case InputEngine.InputMode.Greek:
                        return "ΑΒΓ";
                    case InputEngine.InputMode.Cyrillic:
                        return "АБВ";
                    case InputEngine.InputMode.Arabic:
                        if (InputContext.locale.substring(0, 2) === "fa")
                            return "\u0627\u200C\u0628\u200C\u067E";
                        return "\u0623\u200C\u0628\u200C\u062C";
                    case InputEngine.InputMode.Hebrew:
                        return "\u05D0\u05D1\u05D2";
                    case InputEngine.InputMode.ChineseHandwriting:
                        return "中文";
                    case InputEngine.InputMode.JapaneseHandwriting:
                        return "日本語";
                    case InputEngine.InputMode.KoreanHandwriting:
                        return "한국어";
                    case InputEngine.InputMode.Thai:
                        return "กขค";
                    default:
                        return "Abc";
                    }
                }
                color: keyTextColor
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: keyContentMargin
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 44 * scaleHint
                    capitalization: {
                        if (InputContext.capsLockActive)
                            return Font.AllUppercase;
                        if (InputContext.shiftActive)
                            return Font.MixedCase;
                        return Font.AllLowercase;
                    }
                }
            }
        }
        Canvas {
            id: traceInputKeyGuideLines
            anchors.fill: traceInputKeyPanelBackground
            opacity: 0.1
            onPaint: {
                var ctx = getContext("2d");
                ctx.lineWidth = 1;
                ctx.strokeStyle = Qt.rgba(0xFF, 0xFF, 0xFF);
                ctx.clearRect(0, 0, width, height);
                var i;
                var margin = Math.round(30 * scaleHint);
                if (control.horizontalRulers) {
                    for (i = 0; i < control.horizontalRulers.length; i++) {
                        ctx.beginPath();
                        var y = Math.round(control.horizontalRulers[i]);
                        var rightMargin = Math.round(width - margin);
                        if (i + 1 === control.horizontalRulers.length) {
                            ctx.moveTo(margin, y);
                            ctx.lineTo(rightMargin, y);
                        } else {
                            var dashLen = Math.round(20 * scaleHint);
                            for (var dash = margin, dashCount = 0; dash < rightMargin; dash += dashLen, dashCount++) {
                                if ((dashCount & 1) === 0) {
                                    ctx.moveTo(dash, y);
                                    ctx.lineTo(Math.min(dash + dashLen, rightMargin), y);
                                }
                            }
                        }
                        ctx.stroke();
                    }
                }
                if (control.verticalRulers) {
                    for (i = 0; i < control.verticalRulers.length; i++) {
                        ctx.beginPath();
                        ctx.moveTo(control.verticalRulers[i], margin);
                        ctx.lineTo(control.verticalRulers[i], Math.round(height - margin));
                        ctx.stroke();
                    }
                }
            }
            Connections {
                id: traceInputGuideConnections
                target: control
                function onHorizontalRulersChanged() {
                    traceInputKeyGuideLines.requestPaint();
                }
                function onVerticalRulersChanged() {
                    traceInputKeyGuideLines.requestPaint();
                }
            }
        }
    }

    traceCanvasDelegate: TraceCanvas {
        id: traceCanvas
        onAvailableChanged: {
            if (!available)
                return;
            var ctx = getContext("2d");
            if (parent.canvasType === "fullscreen") {
                ctx.lineWidth = 10;
                ctx.strokeStyle = Qt.rgba(0, 0, 0);
            } else {
                ctx.lineWidth = 10 * scaleHint;
                ctx.strokeStyle = Qt.rgba(0xFF, 0xFF, 0xFF);
            }
            ctx.lineCap = "round";
            ctx.fillStyle = ctx.strokeStyle;
        }
        autoDestroyDelay: 800
        onTraceChanged: if (trace === null)
            opacity = 0
        Behavior on opacity {
            PropertyAnimation {
                easing.type: Easing.OutCubic
                duration: 150
            }
        }
    }

    popupListDelegate: SelectionListItem {
        id: popupListItem
        property real cursorAnchor: popupListLabel.x + popupListLabel.width
        width: popupListLabel.width + popupListLabel.anchors.leftMargin * 2
        height: popupListLabel.height + popupListLabel.anchors.topMargin * 2
        Text {
            id: popupListLabel
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: popupListLabel.height / 2
            anchors.topMargin: popupListLabel.height / 3
            text: decorateText(display, wordCompletionLength)
            color: popupTextColor
            opacity: 0.8
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: Qt.inputMethod.cursorRectangle.height * 0.8
            }
            function decorateText(text, wordCompletionLength) {
                if (wordCompletionLength > 0) {
                    return text.slice(0, -wordCompletionLength) + '<u>' + text.slice(-wordCompletionLength) + '</u>';
                }
                return text;
            }
        }
        states: State {
            name: "current"
            when: popupListItem.ListView.isCurrentItem
            PropertyChanges {
                target: popupListLabel
                opacity: 1.0
            }
        }
    }

    popupListBackground: Item {
        Rectangle {
            width: parent.width
            height: parent.height
            color: popupBackgroundColor
            border {
                width: 1
                color: popupBorderColor
            }
        }
    }

    popupListAdd: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1.0
            duration: 200
        }
    }

    popupListRemove: Transition {
        NumberAnimation {
            property: "opacity"
            to: 0
            duration: 200
        }
    }

    languagePopupListEnabled: true

    languageListDelegate: SelectionListItem {
        id: languageListItem
        width: languageNameTextMetrics.width * 17
        height: languageNameTextMetrics.height + languageListLabel.anchors.topMargin + languageListLabel.anchors.bottomMargin
        Text {
            id: languageListLabel
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: languageNameTextMetrics.height / 2
            anchors.rightMargin: anchors.leftMargin
            anchors.topMargin: languageNameTextMetrics.height / 3
            anchors.bottomMargin: anchors.topMargin
            text: languageNameFormatter.elidedText
            color: popupTextColor
            opacity: 0.8
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: 44 * scaleHint
            }
        }
        TextMetrics {
            id: languageNameTextMetrics
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: 44 * scaleHint
            }
            text: "X"
        }
        TextMetrics {
            id: languageNameFormatter
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: 44 * scaleHint
            }
            elide: Text.ElideRight
            elideWidth: languageListItem.width - languageListLabel.anchors.leftMargin - languageListLabel.anchors.rightMargin
            text: displayName
        }
        states: State {
            name: "current"
            when: languageListItem.ListView.isCurrentItem
            PropertyChanges {
                target: languageListLabel
                opacity: 1
            }
        }
    }

    languageListHighlight: Rectangle {
        color: popupHighlightColor
        radius: 5
    }

    languageListBackground: Rectangle {
        color: popupBackgroundColor
        border {
            width: 1
            color: popupBorderColor
        }
    }

    languageListAdd: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1.0
            duration: 200
        }
    }

    languageListRemove: Transition {
        NumberAnimation {
            property: "opacity"
            to: 0
            duration: 200
        }
    }

    selectionHandle: Image {
        sourceSize.width: 20
        source: resourcePrefix + "selectionhandle.svg"

        MultiEffect {
            source: parent
            anchors.fill: parent
            colorization: 1
            colorizationColor: vkeyboardStyle.textOnPrimaryColor
        }
    }

    fullScreenInputContainerBackground: Rectangle {
        color: "#FFF"
    }

    fullScreenInputBackground: Rectangle {
        color: "#FFF"
    }

    fullScreenInputMargins: Math.round(15 * scaleHint)

    fullScreenInputPadding: Math.round(30 * scaleHint)

    fullScreenInputCursor: Rectangle {
        width: 1
        color: "#000"
        visible: parent.blinkStatus
    }

    fullScreenInputFont.pixelSize: 58 * scaleHint

    functionPopupListDelegate: Item {
        id: functionPopupListItem
        readonly property real iconMargin: 40 * scaleHint
        readonly property real iconWidth: 144 * keyIconScale
        readonly property real iconHeight: 144 * keyIconScale
        width: iconWidth + 2 * iconMargin
        height: iconHeight + 2 * iconMargin
        Image {
            id: functionIcon
            anchors.centerIn: parent
            sourceSize.height: iconHeight
            smooth: false
            source: {
                switch (keyboardFunction) {
                case QtVirtualKeyboard.KeyboardFunction.HideInputPanel:
                    return resourcePrefix + "hidekeyboard.svg";
                case QtVirtualKeyboard.KeyboardFunction.ChangeLanguage:
                    return resourcePrefix + "language.svg";
                case QtVirtualKeyboard.KeyboardFunction.ToggleHandwritingMode:
                    return resourcePrefix + (keyboard.handwritingMode ? "textmode.svg" : "handwriting.svg");
                }
            }
            visible: false
        }
        MultiEffect {
            id: functionIconEffect
            source: functionIcon
            anchors.fill: functionIcon
            colorization: 1
            colorizationColor: vkeyboardStyle.textOnPrimaryColor
        }
    }

    functionPopupListBackground: Item {
        Rectangle {
            readonly property real backgroundMargin: 20 * scaleHint
            x: -backgroundMargin
            y: -backgroundMargin
            width: parent.width + 2 * backgroundMargin
            height: parent.height + 2 * backgroundMargin
            radius: 5
            color: popupBackgroundColor
            border {
                width: 1
                color: popupBorderColor
            }
        }
    }

    functionPopupListHighlight: Rectangle {
        color: popupHighlightColor
        radius: 5
    }
}
