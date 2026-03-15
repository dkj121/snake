import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 300
    height: 50
    visible: true
    property string snakeStyle: "qrc:///Assets/Eternal-Ceremony"
    property var snakeWindow: [null]
    onClosing: {
        for (var i = 0; i < snakeWindow.length; i++) {
            if (snakeWindow[i] !== null) {
                snakeWindow[i].destroy();
            }
        }
        console.log("All snake windows closed.");
    }
    Button {
        width: parent.width / 3
        height: parent.height
        text: "Add"
        onClicked: root.createSnake()
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
            source: root.snakeStyle + "/Relax.gif"
            fillMode: Image.PreserveAspectFit
        }
    }

    Menu {
        id: snakeStyleMenu
        x: parent.width / 3
        MenuItem {
            text: "Eternal-Ceremony"
            onTriggered: root.snakeStyle = "qrc:///Assets/Eternal-Ceremony"
        }
        MenuItem {
            text: "Influences-Through-the-Ages"
            onTriggered: root.snakeStyle = "qrc:///Assets/Influences-Through-the-Ages"
        }
    }

    function createSnake() {
        var component = Qt.createComponent("snake.qml");
        if (component.status === Component.Ready) {
            snakeWindow.push(component.createObject(null));
            snakeWindow[snakeWindow.length - 1].setStyle(root.snakeStyle);
            snakeWindow[snakeWindow.length - 1].show();
        }
    }
}
