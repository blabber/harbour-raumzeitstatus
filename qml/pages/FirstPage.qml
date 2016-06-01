// "THE BEER-WARE LICENSE" (Revision 42):
// <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
// you can do whatever you want with this stuff. If we meet some day, and you
// think this stuff is worth it, you can buy me a beer in return.
//                                                             Tobias Rehbein

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
	id: firstPage

	SilicaFlickable {
		anchors.fill: parent

		PullDownMenu {
			MenuItem {
				text: "Aktualisieren"
				onClicked: controller.startRefresh()
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
	}
}
