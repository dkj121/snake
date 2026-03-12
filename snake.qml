import QtQuick
import QtQuick.Controls

Window {
    id: snake
    width: 100
    height: 100
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"
    property real zoom: 1
    property string currentState: "relax"
    property string style
    property string relaxWebm: "/Relax.webm"
    property string interactWebm: "/Interact.webm"
    property string moveWebm: "/Move.webm"
    property string sitWebm: "/Sit.webm"
    property string sleepWebm: "/Sleep.webm"
    property string specialWebm: "/Special.webm"
    property point passStartPos
    property point passWindowPos
    property bool longPassed: false
    property bool isDoubleClicked: false

    Timer {
        id: longPrassTimer
        interval: 400
        repeat: false
        onTriggered: snake.longPassed = true
    }

    Timer {
        id: clickTimer
        interval: 250
        onTriggered: {
            if (!snake.isDoubleClicked) {
                snake.currentState = "interact";
            }
            snake.isDoubleClicked = false;
        }
    }

    AnimatedImage {
        id: snakeWebm
        anchors.fill: parent
        source: {
            if (snake.currentState === "relax")
                return snake.style + snake.relaxWebm;
            if (snake.currentState === "interact")
                return snake.style + snake.interactWebm;
            if (snake.currentState === "special")
                return snake.style + snake.specialWebm;
            if (snake.currentState === "sit")
                return snake.style + snake.sitWebm;
            if (snake.currentState === "sleep")
                return snake.style + snake.sleepWebm;
            return snake.style + snake.relaxWebm;
        }
        visible: true
        fillMode: Image.PreserveAspectFit
        onFrameChanged: {
            if (currentFrame === frameCount - 1) {
                if (snake.currentState === "interact" || snake.currentState === "special") {
                    snake.currentState = "relax";
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: mouse => {        // 确定起始位置和长按时间
            if (mouse.button === Qt.LeftButton) {
                longPrassTimer.start();
                var global = mapToGlobal(mouse.x, mouse.y);
                snake.passStartPos = Qt.point(global.x, global.y);
                snake.passWindowPos = Qt.point(snake.x, snake.y);
            }
        }
        onReleased: mouse => {       // 重置
            if (mouse.button === Qt.LeftButton) {
                longPrassTimer.stop();
                snake.longPassed = false;
                clickTimer.restart();
            }
        }
        onPositionChanged: mouse => {   // 长按位移
            if (snake.longPassed && (mouse.buttons & Qt.LeftButton)) {
                var currentMouse = mapToGlobal(mouse.x, mouse.y);
                var newX = snake.passWindowPos.x + currentMouse.x - snake.passStartPos.x;
                var newY = snake.passWindowPos.y + currentMouse.y - snake.passStartPos.y;
                newX = Math.max(0, Math.min(Screen.desktopAvailableWidth - snake.width, newX));
                newY = Math.max(0, Math.min(Screen.desktopAvailableHeight - snake.height, newY));
                snake.x = newX;
                snake.y = newY;
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
                snake.zoom += wheel.angleDelta.y / 1200;
                snake.zoom = Math.max(0.5, Math.min(3.0, snake.zoom));
                snake.width = snakeWebm.implicitWidth * snake.zoom;
                snake.height = snakeWebm.implicitHeight * snake.zoom;
                wheel.accepted = true;
            }
        }
        onDoubleClicked: mouse => {   // 双击
            if (mouse.button === Qt.LeftButton) {
                snake.isDoubleClicked = true;
                clickTimer.stop();
                snake.currentState = "special";
            }
        }
    }

    Menu {
        id: snakeMenu
        MenuItem {
            text: "Sit"
            onTriggered: snake.currentState = "sit"
        }
        MenuItem {
            text: "Sleep"
            onTriggered: snake.currentState = "sleep"
        }
        MenuItem {
            text: "Delete"
            onTriggered: snake.destroy()
        }
    }

    function setStyle(snakeStyle: string) {
        style = snakeStyle;
    }
}
