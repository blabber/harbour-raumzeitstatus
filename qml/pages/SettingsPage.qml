// "THE BEER-WARE LICENSE" (Revision 42):
// <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
// you can do whatever you want with this stuff. If we meet some day, and you
// think this stuff is worth it, you can buy me a beer in return.
//                                                             Tobias Rehbein

import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
	id: settingsDialog

	readonly property var intervalItems: [
			{ "label" : "manuell", "value" : 0 },
			{ "label" : "15 min",  "value" : 15 },
			{ "label" : "30 min",  "value" : 30 },
			{ "label" : "1 h",     "value" : 60 }
		]

	DialogHeader {
		id: header
		title: "Einstellungen"
	}

	onOpened: {
		intervalItems.forEach(function(element, index){
			if(element["value"] == model.refreshInterval){
				refreshIntervalCombo.currentIndex = index;
				return;
			}
		});
	}

	onAccepted: {
		model.refreshInterval =
			intervalItems[refreshIntervalCombo.currentIndex]["value"];
		controller.saveConfig();
	}

	ComboBox {
		id: refreshIntervalCombo

		label: "Aktualisierung:"

		anchors {
			top: header.bottom
		}

		menu: ContextMenu {
			MenuItem { text: intervalItems[0]["label"] }
			MenuItem { text: intervalItems[1]["label"] }
			MenuItem { text: intervalItems[2]["label"] }
			MenuItem { text: intervalItems[3]["label"] }
		}
	}
}
