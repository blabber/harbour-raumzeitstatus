// "THE BEER-WARE LICENSE" (Revision 42):
// <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
// you can do whatever you want with this stuff. If we meet some day, and you
// think this stuff is worth it, you can buy me a beer in return.
//                                                             Tobias Rehbein

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
	initialPage: Component { FirstPage { } }
	cover: Qt.resolvedUrl("cover/CoverPage.qml")

	Model {
		id: model
	}

	Controller {
		id: python
	}
}
