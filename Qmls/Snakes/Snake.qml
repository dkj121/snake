import QtQuick

Item {
    id: root
    property string currentState: "/Relax"
    property string style
    property bool isMoveable: true
    property string rightOrLeft: "-right.gif"
    property size gifSize: Qt.size(snakeGif.implicitWidth, snakeGif.implicitHeight)
    property var snakeWindow: null

    onCurrentStateChanged: {
        console.log("Current state changed to: " + currentState);
    }

    onStyleChanged: {
        console.log("Style changed to: " + style);
    }

    onRightOrLeftChanged: {
        console.log("Direction changed to: " + rightOrLeft);
    }

    SnakeController {
        id: snakeController
        snake: root
        snakeWindow: root.snakeWindow
    }

    SnakeGif {
        id: snakeGif
        snake: root
        snakeWindow: root.snakeWindow
    }
}
