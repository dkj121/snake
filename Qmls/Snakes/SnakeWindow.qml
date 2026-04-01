import QtQuick

Window {
    id: root
    width: 200
    height: 200
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"

    property real zoom: 0.5
    property point passStartPos
    property point passWindowPos
    property bool longPassed: false
    property bool isDoubleClicked: false

    Behavior on x {
        NumberAnimation {
            duration: 100
            easing.type: Easing.Linear
        }
    }

    Behavior on y {
        NumberAnimation {
            duration: 100
            easing.type: Easing.Linear
        }
    }

    onXChanged: {
        console.log("X changed to: " + x);
    }

    onZoomChanged: {
        console.log("Zoom changed to: " + zoom);
    }

    Snake {
        id: snake
        anchors.fill: parent
        snakeWindow: root
    }

    SnakeWindowController {
        id: snakeWindowController
        snakeWindow: root
        snake: snake
    }

    SnakeMenu {
        id: snakeMenu
        snake: snake
        snakeWindow: root
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: mouse => {        // 确定起始位置和长按时间
            if (mouse.button === Qt.LeftButton) {
                snakeWindowController.longPrassTimer.start();
                var global = mapToGlobal(mouse.x, mouse.y);
                root.passStartPos = Qt.point(global.x, global.y);
                root.passWindowPos = Qt.point(root.x, root.y);
            }
        }
        onReleased: mouse => {       // 重置
            if (mouse.button === Qt.LeftButton) {
                snakeWindowController.longPrassTimer.stop();
                root.longPassed = false;
                snakeWindowController.clickTimer.restart();
            }
        }
        onPositionChanged: mouse => {   // 长按位移
            if (root.longPassed && (mouse.buttons & Qt.LeftButton)) {
                var currentMouse = mapToGlobal(mouse.x, mouse.y);
                var newX = root.passWindowPos.x + currentMouse.x - root.passStartPos.x;
                var newY = root.passWindowPos.y + currentMouse.y - root.passStartPos.y;
                newX = Math.max(0, Math.min(Screen.desktopAvailableWidth - snake.width, newX));
                newY = Math.max(0, Math.min(Screen.desktopAvailableHeight - snake.height, newY));
                root.x = newX;
                root.y = newY;
            }
        }

        onClicked: mouse => {           // 右键菜单
            if (mouse.button === Qt.RightButton) {
                var globalPos = Qt.point(mouseX, mouseY);
                snakeMenu.popup(globalPos.x, globalPos.y);
            }
        }
        onWheel: wheel => {           // ctrl + 滚轮调节大小
            if (wheel.modifiers & Qt.ControlModifier) {
                root.zoom += wheel.angleDelta.y / 1200;
                root.zoom = Math.max(0.5, Math.min(3.0, root.zoom));
                root.width = 200 * root.zoom;
                root.height = 200 * root.zoom;
                wheel.accepted = true;
            }
        }
        onDoubleClicked: mouse => {   // 双击
            if (mouse.button === Qt.LeftButton) {
                root.isDoubleClicked = true;
                snakeWindowController.clickTimer.stop();
                snake.currentState = "/Special";
            }
        }
    }

    function setStyle(style, speed) {
        snake.style = style;
        snake.speed = speed;
    }

    function deleteSnake() {
        root.destroy();
    }
}
