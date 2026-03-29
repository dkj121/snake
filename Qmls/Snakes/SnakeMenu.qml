import QtQuick
import QtQuick.Controls

Menu {
    id: root
    property var snake
    property var snakeWindow

    MenuItem {
        text: "Moveable"
        onTriggered: root.snake.isMoveable = !root.snake.isMoveable
    }
    MenuItem {
        text: "Sit"
        onTriggered: root.snake.currentState = "/Sit"
    }
    MenuItem {
        text: "Sleep"
        onTriggered: root.snake.currentState = "/Sleep"
    }
    MenuItem {
        text: "Delete"
        onTriggered: root.snakeWindow.deleteSnake()
    }
}
