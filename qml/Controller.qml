// "THE BEER-WARE LICENSE" (Revision 42):
// <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
// you can do whatever you want with this stuff. If we meet some day, and you
// think this stuff is worth it, you can buy me a beer in return.
//                                                             Tobias Rehbein

import QtQuick 2.0
import io.thp.pyotherside 1.4

Python {
	Component.onCompleted: {
		addImportPath(Qt.resolvedUrl('../python'));

		setHandler('statusRefreshed', function(newvalue) {
			model.lastRefresh = new Date().getTime();
			model.refreshing = false;
			model.door = newvalue;
		});

		setHandler('configLoaded', function(newvalue) {
			var config = newvalue['configuration'];
			model.refreshInterval = config['refresh_interval'];
		});

		importModule('controller', function () {
			startRefresh();
		});
	}

	function startRefresh() {
		model.refreshing = true;
		call('controller.instance.refresh', function() {});
	}

	function saveConfig() {
		var config = {
			'configuration' : {
				'refresh_interval' : model.refreshInterval
			}
		};
		call('controller.instance.save_config', [config],  function() {});
	}

	onError: {
		console.log('python error: ' + traceback);
	}

	onReceived: {
		console.log('got message from python: ' + data);
	}
}
