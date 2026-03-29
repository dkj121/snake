import "." as Setting
import QtQuick
import QtQuick.Controls

Window {
    id: settings
    width: 800
    height: 500
    visible: true

    Text {
        x: 0
        height: 30
        width: parent.width / 2
        text: "Snake Style:" + Setting.StyleManager.getStyleName()
        font.pixelSize: 24
    }

    Button {
        x: parent.width / 2
        height: 30
        width: parent.width / 2
        text: Setting.StyleManager.getStyleName()
        onClicked: snakeStyleMenu.popup()
    }

    Menu {
        id: snakeStyleMenu
        x: parent.width / 2
        width: parent.width / 2
        MenuItem {
            text: "Eternal-Ceremony"
            onTriggered: {
                Setting.StyleManager.setStyleByName("Eternal-Ceremony");
            }
        }
        MenuItem {
            text: "Influences-Through-the-Ages"
            onTriggered: {
                Setting.StyleManager.setStyleByName("Influences-Through-the-Ages");
            }
        }
    }
}
