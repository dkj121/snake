import QtQuick

Item {
    id: root
    property string currentState: "/Relax"
    property string style
    property bool isMoveable: true
    property string rightOrLeft: "-right.gif"
    property size gifSize: Qt.size(snakeGif.implicitWidth, snakeGif.implicitHeight)

    SnakeController {
        id: snakeController
        snake: root
    }

    SnakeGif {
        id: snakeGif
        snake: root
    }
}
