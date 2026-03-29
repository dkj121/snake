import QtQuick

Item {
    id: root
    property var snakeWindow: null
    property var snake: null
    property alias longPrassTimer: longPrassTimer
    property alias clickTimer: clickTimer

    Timer {
        id: longPrassTimer
        interval: 400
        repeat: false
        onTriggered: {
            if (root.snakeWindow !== null) {
                root.snakeWindow.longPassed = true;
            }
        }
    }

    Timer {
        id: clickTimer
        interval: 250
        repeat: false
        onTriggered: {
            if (!root.snake.isDoubleClicked && root.snake.currentState !== "/Sit" && root.snake.currentState !== "/Sleep" && root.snake.currentState !== "/Special" && root.snake !== null) {
                root.snake.currentState = "/Interact";
            }
            if (root.snakeWindow !== null) {
                root.snakeWindow.isDoubleClicked = false;
            }
        }
    }
}
