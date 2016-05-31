// "THE BEER-WARE LICENSE" (Revision 42):
// <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
// you can do whatever you want with this stuff. If we meet some day, and you
// think this stuff is worth it, you can buy me a beer in return.
//                                                             Tobias Rehbein

import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
	property string status: "?"

	width: parent.width<parent.height?parent.width:parent.height
	height: width

	color: {
		if (status == 1)
			return "lightgreen";
		else if (status == 0)
			return "red";
		else
			return "lightgrey";
	}

	border {
		color: "white"
		width: 10
	}

	Image {
		source: "../../images/RaumZeitLabor.svg"
		anchors.centerIn: parent
		width: parent.width - (2*Theme.paddingLarge)
		height: parent.height
		fillMode: Image.PreserveAspectFit
	}

	radius: width*0.5
}
