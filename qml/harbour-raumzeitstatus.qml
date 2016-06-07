// "THE BEER-WARE LICENSE" (Revision 42):
// <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
// you can do whatever you want with this stuff. If we meet some day, and you
// think this stuff is worth it, you can buy me a beer in return.
//                                                             Tobias Rehbein

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "cover"

ApplicationWindow
{
	initialPage: Component { FirstPage { } }
	cover: CoverPage { id: coverPage }

	Model { id: model }
	Controller { id: controller }

	Timer {
		property double refreshInterval: model.refreshInterval * 60 * 1000

		interval: 5 * 60 * 1000
		repeat: true
		triggeredOnStart: true

		onTriggered: {
			var now = new Date().getTime();
			if ((now - model.lastRefresh) < refreshInterval) {
				return;
			}
			controller.startRefresh();
		}

		running: {
			return model.refreshInterval > 0 &&
				(Qt.application.state == Qt.ApplicationActive ||
				coverPage.status == Cover.Active);
		}
	}
}
