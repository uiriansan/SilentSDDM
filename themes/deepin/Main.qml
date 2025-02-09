/***********************************************************************/

import QtQuick 2.0
import QtGraphicalEffects 1.0
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080
    state: "stateLock"

    readonly property int hMargin: 40
    readonly property int vMargin: 30
    readonly property int m_powerButtonSize: 40
    readonly property color textColor: "#ffffff"

    TextConstants { id: textConstants }


    states: [
		State {
			name: "stateLock"
			PropertyChanges { target: lockFrame; opacity: 1}
			PropertyChanges { target: loginFrame; opacity: 0}
            PropertyChanges { target: bgBlur; radius: 0}
			PropertyChanges { target: loginFrame; scale: 0.5 }
		},
        State {
            name: "stateLogin"
			PropertyChanges { target: lockFrame; opacity: 0}
            PropertyChanges { target: loginFrame; opacity: 1}
            PropertyChanges { target: bgBlur; radius: config.blur}
			PropertyChanges { target: loginFrame; scale: 1 }
        }

    ]
    transitions: Transition {
        PropertyAnimation { duration: 150; properties: "opacity";  }
        PropertyAnimation { duration: 400; properties: "radius"; }
		PropertyAnimation { duration: 200; properties: "scale" }
    }

    Repeater {
        model: screenModel
        Background {
            x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
            source: config.background
            fillMode: Image.Tile
            onStatusChanged: {
                if (status == Image.Error && source !== config.defaultBackground) {
                    source = config.defaultBackground
                }
            }
        }
    }

    Item {
        id: mainFrame
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height

        Image {
            id: mainFrameBackground
            anchors.fill: parent
            source: config.background
        }

        FastBlur {
            id: bgBlur
            anchors.fill: mainFrameBackground
            source: mainFrameBackground
            radius: 0
        }

        Item {
            id: centerArea
            width: parent.width
            height: parent.height / 3
            anchors.top: parent.top
            anchors.topMargin: parent.height / 5

			LockFrame {
                id: lockFrame
				focus: true
                anchors.fill: parent
                enabled: root.state == "stateLock"
				onNeedLogin: {
					root.state = "stateLogin"
					loginFrame.input.forceActiveFocus()
				}
            }
			LoginFrame {
                id: loginFrame
                anchors.fill: parent
				anchors.centerIn: parent
                enabled: root.state == "stateLogin"
                opacity: 0
				onNeedClose: {
                    root.state = "stateLock"
					lockFrame.focus = true
                }
				scale: 0.5
			}
			UserFrame {
				id: userFrame
			}

            //PowerFrame {
            //    id: powerFrame
            //    anchors.fill: parent
            //    enabled: root.state == "statePower"
            //    onNeedClose: {
            //        root.state = "stateLogin"
            //        loginFrame.input.forceActiveFocus()
            //    }
            //    onNeedShutdown: sddm.powerOff()
            //    onNeedRestart: sddm.reboot()
            //    onNeedSuspend: sddm.suspend()
            //}
            //
            //SessionFrame {
            //    id: sessionFrame
            //    anchors.fill: parent
            //    enabled: root.state == "stateSession"
            //    onSelected: {
            //        console.log("Selected session:", index)
            //        root.state = "stateLogin"
            //        loginFrame.sessionIndex = index
            //        loginFrame.input.forceActiveFocus()
            //    }
            //    onNeedClose: {
            //        root.state = "stateLogin"
            //        loginFrame.input.forceActiveFocus()
            //    }
            //}
            //
            //UserFrame {
            //    id: userFrame
            //    anchors.fill: parent
            //    enabled: root.state == "stateUser"
            //    onSelected: {
            //        console.log("Select user:", userName)
            //        root.state = "stateLogin"
            //        loginFrame.userName = userName
            //        loginFrame.input.forceActiveFocus()
            //    }
            //    onNeedClose: {
            //        root.state = "stateLogin"
            //        loginFrame.input.forceActiveFocus()
            //    }
            //}

            
        }

        //Item {
        //    id: powerArea
        //    visible: ! loginFrame.isProcessing
        //    anchors {
        //        bottom: parent.bottom
        //        right: parent.right
        //    }
        //    width: parent.width / 3
        //    height: parent.height / 7
        //
        //    Row {
        //        spacing: 20
        //        anchors.right: parent.right
        //        anchors.rightMargin: hMargin
        //        anchors.verticalCenter: parent.verticalCenter
        //
        //        ImgButton {
        //            id: sessionButton
        //            width: m_powerButtonSize
        //            height: m_powerButtonSize
        //            visible: sessionFrame.isMultipleSessions()
        //            normalImg: sessionFrame.getCurrentSessionIconIndicator()
        //            onClicked: {
        //                root.state = "stateSession"
        //                sessionFrame.focus = true
        //            }
        //            onEnterPressed: sessionFrame.currentItem.forceActiveFocus()
        //
        //
        //            KeyNavigation.tab: loginFrame.input
        //            KeyNavigation.backtab: {
        //                if (userButton.visible) {
        //                    return userButton
        //                }
        //                else {
        //                    return shutdownButton
        //                }
        //            }
        //        }
        //
        //        ImgButton {
        //            id: userButton
        //            width: m_powerButtonSize
        //            height: m_powerButtonSize
        //            visible: userFrame.isMultipleUsers()
        //
        //            normalImg: "icons/switchframe/userswitch_normal.png"
        //            hoverImg: "icons/switchframe/userswitch_hover.png"
        //            pressImg: "icons/switchframe/userswitch_press.png"
        //            onClicked: {
        //                console.log("Switch User...")
        //                root.state = "stateUser"
        //                userFrame.focus = true
        //            }
        //            onEnterPressed: userFrame.currentItem.forceActiveFocus()
        //            KeyNavigation.backtab: shutdownButton
        //            KeyNavigation.tab: {
        //                if (sessionButton.visible) {
        //                    return sessionButton
        //                }
        //                else {
        //                    return loginFrame.input
        //                }
        //            }
        //        }
        //
        //        ImgButton {
        //            id: shutdownButton
        //            width: m_powerButtonSize
        //            height: m_powerButtonSize
        //            visible: true//sddm.canPowerOff
        //
        //            normalImg: "icons/switchframe/powermenu.png"
        //            onClicked: {
        //                console.log("Show shutdown menu")
        //                root.state = "statePower"
        //                powerFrame.focus = true
        //            }
        //            onEnterPressed: powerFrame.shutdown.focus = true
        //            KeyNavigation.backtab: loginFrame.button
        //            KeyNavigation.tab: {
        //                if (userButton.visible) {
        //                    return userButton
        //                }
        //                else if (sessionButton.visible) {
        //                    return sessionButton
        //                }
        //                else {
        //                    return loginFrame.input
        //                }
        //            }
        //        }
        //    }
        //}

        MouseArea {
            z: -1
            anchors.fill: parent
            onClicked: {
                root.state = "stateLogin"
                loginFrame.input.forceActiveFocus()
            }
        }
    }
}
