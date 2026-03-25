import QtQuick
import QtQuick.Controls

Window {
    id: settings
    width: 800
    height: 500
    visible: true
    property string snakeStyle
    property var mainWindow: null

    onSnakeStyleChanged: {
        console.log("Snake style changed to: " + snakeStyle);
    }

    Text {
        x: 0
        height: 30
        width: parent.width / 2
        text: settings.snakeStyle.split("/").slice(-1)[0]
        font.pixelSize: 24
    }

    Button {
        x: parent.width / 2
        height: 30
        width: parent.width / 2
        text: "Style"
        onClicked: snakeStyleMenu.popup()
    }

    Menu {
        id: snakeStyleMenu
        x: parent.width / 2
        width: parent.width / 2
        MenuItem {
            text: "Eternal-Ceremony"
            onTriggered: {
                settings.snakeStyle = "qrc:///Gifs/Assets/Eternal-Ceremony";
                settings.mainWindow.snakeStyle = settings.snakeStyle;
            }
        }
        MenuItem {
            text: "Influences-Through-the-Ages"
            onTriggered: {
                settings.snakeStyle = "qrc:///Gifs/Assets/Influences-Through-the-Ages";
                settings.mainWindow.snakeStyle = settings.snakeStyle;
            }
        }
    }
}
