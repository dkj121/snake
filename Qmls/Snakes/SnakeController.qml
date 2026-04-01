// SnakeWindowController.qml
import QtQuick
import QtQuick.Window // 必须导入

Item {
    id: root
    property var snake: null
    property var snakeWindow: null
    property int minInterval: 10000
    property int maxInterval: 30000

    // 状态随机切换定时器
    Timer {
        id: stateTimer
        interval: root.setNextMoveInterval()
        repeat: true
        running: true
        onTriggered: {
            if (!root.snake || !root.snake.isMoveable)
                return;
            var state = root.snake.currentState;
            if (state !== "/Sit" && state !== "/Sleep" && state !== "/Special") {
                root.snake.currentState = (state === "/Relax") ? "/Move" : "/Relax";
                interval = root.setNextMoveInterval();
            }
        }
    }

    // 移动定时器
    Timer {
        id: moveTimer
        interval: 50
        running: root.snake && root.snake.currentState === "/Move" && root.snake.isMoveable
        repeat: true
        onTriggered: {
            if (!root.snake || root.snake.currentState !== "/Move")
                return;

            var delta = 2 * root.snakeWindow.zoom * (root.snake.rightOrLeft === "-right.gif" ? 1 : -1);
            var newX = root.snakeWindow.x + delta;
            var reachedBoundary = false;

            if (root.snake.rightOrLeft === "-right.gif") {
                var maxX = Screen.desktopAvailableWidth - root.snakeWindow.width;
                if (newX >= maxX) {
                    newX = maxX;
                    reachedBoundary = true;
                }
            } else {
                if (newX <= 0) {
                    newX = 0;
                    reachedBoundary = true;
                }
            }

            root.snakeWindow.x = newX; // Behavior 会平滑过渡

            if (reachedBoundary) {
                root.snake.rightOrLeft = (root.snake.rightOrLeft === "-right.gif") ? "-left.gif" : "-right.gif";
            }
        }
    }

    function setNextMoveInterval() {
        return Math.floor(root.minInterval + Math.random() * (root.maxInterval - root.minInterval + 1));
    }
}
