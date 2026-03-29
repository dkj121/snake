import QtQuick

Window {
    id: root
    width: 100
    height: 100
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"

    property real zoom: 1
    property point passStartPos
    property point passWindowPos
    property bool longPassed: false
    property bool isDoubleClicked: false

    Snake {
        id: snake
        anchors.fill: parent
    }

    SnakeWindowController {
        id: snakeWindowController
        snakeWindow: root
        snake: snake
    }

    SnakeMenu {
        id: snakeMenu
        snake: snake
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
                root.zoom = Math.max(0.1, Math.min(1.0, root.zoom));
                root.width = snake.gifSize.width * root.zoom;
                root.height = snake.gifSize.height * root.zoom;
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

    function setStyle(style) {
        snake.style = style;
    }
}
