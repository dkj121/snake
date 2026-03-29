import "./Setting/" as Setting
import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 300
    height: 50
    visible: true
    property var snakeWindows: []
    property var settingsWindow: null

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
        text: "Settings"
        onClicked: root.openSettings()
    }

    AnimatedImage {
        x: parent.width / 3 * 2
        width: parent.width / 3
        height: parent.height
        source: Setting.StyleManager.getStylePath() + "/Relax-right.gif"
        fillMode: Image.PreserveAspectFit
    }

    function createSnake() {
        var component = Qt.createComponent("qrc:///Qmls/Snakes/SnakeWindow.qml");
        console.log("Error creating snake window: " + component.status + " - " + component.errorString());
        if (component.status === Component.Ready) {
            var snakeWindow = component.createObject(null);
            if (snakeWindow) {
                snakeWindow.setStyle(Setting.StyleManager.getStylePath());
                snakeWindows.push(snakeWindow);
                snakeWindows[snakeWindows.length - 1].show();
            }
        }
    }
    function openSettings() {
        if (settingsWindow === null) {
            var component = Qt.createComponent("qrc:///Qmls/Setting/Settings.qml");
            if (component.status === Component.Ready) {
                settingsWindow = component.createObject(null);
                settingsWindow.show();
            }
        }
    }
}
