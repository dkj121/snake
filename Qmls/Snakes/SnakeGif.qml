import QtQuick

AnimatedImage {
    property var snake: null

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
        if ((snake.currentState === "/Special" || snake.currentState === "/Interact") && currentFrame === frameCount - 1) {
            snake.currentState = "/Relax";
        } else if (snake.currentState === "/Move") {
            // TODO: 这里可以添加一些随机移动的逻辑，改变位置以及切换方向的动画
        }
    }
}
