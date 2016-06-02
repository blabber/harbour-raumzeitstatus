// "THE BEER-WARE LICENSE" (Revision 42):
// <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
// you can do whatever you want with this stuff. If we meet some day, and you
// think this stuff is worth it, you can buy me a beer in return.
//                                                             Tobias Rehbein

import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
	id: settingsDialog

	property int refreshInterval: 0

	DialogHeader {
		id: header
		title: "Einstellungen"
	}

	onOpened: {
		refreshInterval = model.refreshInterval;

		switch (refreshInterval) {
			case 0:
				refreshIntervalCombo.currentIndex = 0;
				break;
			case 15:
				refreshIntervalCombo.currentIndex = 1;
				break;
			case 30:
				refreshIntervalCombo.currentIndex = 2;
				break;
			case 60:
				refreshIntervalCombo.currentIndex = 3;
				break;
			default:
				console.log("Invalid refreshInterval:", refreshInterval);
				refreshInterval = 0;
		}
	}

	onAccepted: {
		model.refreshInterval = refreshInterval
	}

	ComboBox {
		id: refreshIntervalCombo

		label: "Aktualisierung:"

		anchors {
			top: header.bottom
		}

		menu: ContextMenu {
			MenuItem {
				text: "manuell"
				onClicked: settingsDialog.refreshInterval = 0;
			}
			MenuItem {
				text: "15 min"
				onClicked: settingsDialog.refreshInterval = 15;
			}
			MenuItem {
				text: "30 min"
				onClicked: settingsDialog.refreshInterval = 30;
			}
			MenuItem {
				text: "1 h"
				onClicked: settingsDialog.refreshInterval = 60;
			}
		}
	}
}
