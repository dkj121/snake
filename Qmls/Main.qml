import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 300
    height: 50
    visible: true
    property string snakeStyle: "qrc:///Gifs/Assets/Eternal-Ceremony"
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

    Page {
        x: parent.width / 3 * 2
        width: parent.width / 3
        height: parent.height
        AnimatedImage {
            width: parent.width
            height: parent.height
            source: root.snakeStyle + "/Relax-right.gif"
            fillMode: Image.PreserveAspectFit
        }
    }

    function createSnake() {
        var component = Qt.createComponent("qrc:///Qmls/Qmls/snake.qml");
        if (component.status === Component.Ready) {
            snakeWindows.push(component.createObject(null));
            snakeWindows[snakeWindows.length - 1].setStyle(root.snakeStyle);
            snakeWindows[snakeWindows.length - 1].show();
            console.log("SnakeWindow created with style: " + root.snakeStyle);
        } else {
            console.error("Failed to create snake window: " + component.errorString());
        }
    }
    function openSettings() {
        if (settingsWindow === null) {
            var component = Qt.createComponent("qrc:///Qmls/Qmls/Settings.qml");
            if (component.status === Component.Ready) {
                settingsWindow = component.createObject(null);
                settingsWindow.snakeStyle = root.snakeStyle;
                settingsWindow.mainWindow = root;
                settingsWindow.show();
                console.log("Settings window created with snake style: " + root.snakeStyle);
            }
        } else {
            settingsWindow.visible = !settingsWindow.visible;
            console.error("Settings window already open, toggling visibility.");
        }
    }
}
