// "THE BEER-WARE LICENSE" (Revision 42):
// <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
// you can do whatever you want with this stuff. If we meet some day, and you
// think this stuff is worth it, you can buy me a beer in return.
//                                                             Tobias Rehbein

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
	SilicaFlickable {
		anchors.fill: parent

		PullDownMenu {
			MenuItem {
				text: "Einstellungen"
				onClicked: pageStack.push("SettingsPage.qml")
			}

			MenuItem {
				text: !model.refreshing ? "Aktualisieren" : "Aktualisiere..."
				onClicked: controller.startRefresh()
				enabled: !model.refreshing
			}

			busy: model.refreshing
		}

		StatusIndicator {
			status: model.door
			width: parent.width - (2*Theme.horizontalPageMargin)
			height: width
			anchors {
				horizontalCenter: parent.horizontalCenter
				top: parent.top
				topMargin: Theme.paddingLarge
			}
		}

		Label {
			anchors {
				bottom: parent.bottom
				bottomMargin: Theme.paddingLarge
				right: parent.right
				rightMargin: Theme.horizontalPageMargin
			}

			text: new Date(model.lastRefresh).toString()
			color: Theme.secondaryHighlightColor
			font.pixelSize: Theme.fontSizeExtraSmall
		}
	}
}
