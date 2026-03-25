import QtQuick
import QtQuick.Controls

Window {
    id: snake
    width: 100
    height: 100
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"
    property real zoom: 1
    property int minInterval: 10000
    property int maxInterval: 30000
    property string currentState: "relax"
    property string style
    property string relaxGif: "/Relax-right.gif"
    property string interactGif: "/Interact-right.gif"
    property string moveGif: "/Move-right.gif"
    property string sitGif: "/Sit-right.gif"
    property string sleepGif: "/Sleep-right.gif"
    property string specialGif: "/Special-right.gif"
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

    Timer {
        id: moveTimer
        interval: snake.setNextMoveInterval()
        repeat: true
        onTriggered: {
            if (snake.currentState === "relax") {
                snake.currentState = "move";
                moveTimer.interval = snake.setNextMoveInterval();
                moveTimer.restart();
            } else if (snake.currentState === "move") {
                snake.currentState = "relax";
                moveTimer.interval = snake.setNextMoveInterval();
                moveTimer.restart();
            }
        }
    }

    AnimatedImage {
        id: snakeGif
        anchors.fill: parent
        source: {
            switch (snake.currentState) {
            case "relax":
                moveTimer.restart();
                return snake.style + snake.relaxGif;
            case "interact":
                return snake.style + snake.interactGif;
            case "move":
                moveTimer.restart();
                return snake.style + snake.moveGif;
            case "sit":
                return snake.style + snake.sitGif;
            case "sleep":
                return snake.style + snake.sleepGif;
            case "special":
                return snake.style + snake.specialGif;
            default:
                return snake.style + snake.relaxGif;
            }
        }
        visible: true
        fillMode: Image.PreserveAspectFit
        onSourceChanged: {
            console.log("Source changed to:", source);
        }
        onFrameChanged: {
            if ((snake.currentState === "special" || snake.currentState === "interact") && currentFrame === frameCount - 1) {
                snake.currentState = "relax";
                moveTimer.restart();
            } else if (snake.currentState === "move") {
                snake.x += (Math.random() - 0.5) * 20;
                snake.y += (Math.random() - 0.5) * 20;
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
                snake.zoom = Math.max(0.1, Math.min(1.0, snake.zoom));
                snake.width = snakeGif.implicitWidth * snake.zoom;
                snake.height = snakeGif.implicitHeight * snake.zoom;
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
        console.log("Style set to:", style);
    }

    function setNextMoveInterval() {
        return Math.floor(snake.minInterval + Math.random() * (snake.maxInterval - snake.minInterval + 1));
    }

    Component.onCompleted: {
        console.log("Snake initialized with style:", snake.style);
    }
}
