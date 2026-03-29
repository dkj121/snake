import QtQuick
import QtQuick.Window

AnimatedImage {
    id: root
    property var snake: null
    property var snakeWindow: null
    property bool moving: false

    onMovingChanged: {
        console.log("Moving state changed:", moving);
    }

    anchors.fill: parent
    source: {
        if (!snake || !snake.style || !snake.currentState)
            return "";
        let path;
        switch (snake.currentState) {
        case "/Relax":
        case "/Interact":
        case "/Move":
        case "/Sit":
        case "/Sleep":
        case "/Special":
        default:
            path = snake.style + snake.currentState + snake.rightOrLeft;
            break;
        }
        return Qt.resolvedUrl(path);
    }
    visible: true
    fillMode: Image.PreserveAspectFit

    onFrameChanged: {
        if (!snakeWindow)
            return;

        if ((snake.currentState === "/Special" || snake.currentState === "/Interact") && currentFrame === frameCount - 1) {
            snake.currentState = "/Relax";
        }
    }
}
