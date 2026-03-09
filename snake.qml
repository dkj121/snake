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
    property string relaxGif: "/Relax.gif"
    property string interactGif: "/Interact.gif"
    property string sitGif: "/Sit.gif"
    property string sleepGif: "/Sleep.gif"
    property string specialGif: "/Special.gif"
    property point passStartPos
    property point passWindowPos
    property bool longPassed: false
    property bool isDoubleClicked: false

    Timer {
        id: longPrassTimer
        interval: 400
        repeat: false
        onTriggered: longPassed = true
    }

    Timer {
        id: clickTimer
        interval: 250
        onTriggered: {
            if (!isDoubleClicked) {
                currentState = "interact";
            }
            isDoubleClicked = false;
        }
    }

    AnimatedImage {
        id: snakeGif
        anchors.fill: parent
        source: {
            if (currentState === "relax")
                return style + relaxGif;
            if (currentState === "interact")
                return style + interactGif;
            if (currentState === "special")
                return style + specialGif;
            if (currentState === "sit")
                return style + sitGif;
            if (currentState === "sleep")
                return style + sleepGif;
            return style + relaxGif;
        }
        visible: true
        fillMode: Image.PreserveAspectFit
        onFrameChanged: {
            if (currentFrame === frameCount - 1) {
                if (currentState === "interact" || currentState === "special") {
                    currentState = "relax";
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
                passStartPos = Qt.point(global.x, global.y);
                passWindowPos = Qt.point(snake.x, snake.y);
            }
        }
        onReleased: mouse => {       // 重置
            if (mouse.button === Qt.LeftButton) {
                longPrassTimer.stop();
                longPassed = false;
                clickTimer.restart();
            }
        }
        onPositionChanged: mouse => {   // 长按位移
            if (longPassed && (mouse.buttons & Qt.LeftButton)) {
                var currentMouse = mapToGlobal(mouse.x, mouse.y);
                var newX = passWindowPos.x + currentMouse.x - passStartPos.x;
                var newY = passWindowPos.y + currentMouse.y - passStartPos.y;
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
                zoom += wheel.angleDelta.y / 1200;
                zoom = Math.max(0.5, Math.min(3.0, zoom));
                snake.width = snakeGif.implicitWidth * zoom;
                snake.height = snakeGif.implicitHeight * zoom;
                wheel.accepted = true;
            }
        }
        onDoubleClicked: mouse => {   // 双击
            if (mouse.button === Qt.LeftButton) {
                isDoubleClicked = true;
                clickTimer.stop();
                currentState = "special";
            }
        }
    }

    Menu {
        id: snakeMenu
        MenuItem {
            text: "Sit"
            onTriggered: currentState = "sit"
        }
        MenuItem {
            text: "Sleep"
            onTriggered: currentState = "sleep"
        }
        MenuItem {
            text: "Delete"
            onTriggered: snake.destroy()
        }
    }

    function setStyle(snakeStyle: String) {
        style = snakeStyle;
    }
}
