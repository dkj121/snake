import QtQuick

Item {
    id: root
    property var snake: null
    property int minInterval: 10000
    property int maxInterval: 30000

    Timer {
        id: moveTimer
        interval: root.maxInterval
        repeat: true
        running: true
        onTriggered: {
            if (!root.snake || !root.snake.isMoveable) {
                return;
            }
            if (root.snake.isMoveable && root.snake.currentState !== "/Sit" && root.snake.currentState !== "/Sleep" && root.snake.currentState !== "/Special") {
                if (root.snake.currentState === "/Relax") {
                    root.snake.currentState = "/Move";
                } else if (root.snake.currentState === "/Move") {
                    root.snake.currentState = "/Relax";
                }
                moveTimer.interval = root.setNextMoveInterval();
            }
        }
    }

    function setNextMoveInterval() {
        return Math.floor(root.minInterval + Math.random() * (root.maxInterval - root.minInterval + 1));
    }
}
