import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 300
    height: 50
    visible: true

    property string snakeStyle: "Assets/Eternal-Ceremony"
    property var snakeWindow: [null]

    Button {
        width: parent.width / 3
        height: parent.height
        text: "Add"
        onClicked: createSnake()
    }
    Button {
        x: parent.width / 3
        width: parent.width / 3
        height: parent.height
        text: "Style"
        onClicked: snakeStyleMenu.popup()
    }

    Page {
        x: parent.width / 3 * 2
        width: parent.width / 3
        height: parent.height
        AnimatedImage {
            width: parent.width
            height: parent.height
            source: snakeStyle + "/Relax.gif"
            fillMode: Image.PreserveAspectFit
        }
    }

    Menu {
        id: snakeStyleMenu
        x: parent.width / 3
        MenuItem {
            text: "Eternal-Ceremony"
            onTriggered: snakeStyle = "Assets/Eternal-Ceremony"
        }
        MenuItem {
            text: "Influences-Through-the-Ages"
            onTriggered: snakeStyle = "Assets/Influences-Through-the-Ages"
        }
    }

    function createSnake() {
        var component = Qt.createComponent("snake.qml");
        if (component.status === Component.Ready) {
            snakeWindow.push(component.createObject(null));
            snakeWindow[snakeWindow.length - 1].setStyle(snakeStyle);
            snakeWindow[snakeWindow.length - 1].show();
        }
    }
}
