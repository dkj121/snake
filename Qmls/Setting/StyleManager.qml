pragma Singleton
import QtQuick

QtObject {
    id: snakeStyle

    readonly property var styles: [
        {
            name: "Eternal Ceremony",
            path: "qrc:///Assets/Eternal-Ceremony",
            speed: 2
        },
        {
            name: "Influences-Through-the-Ages",
            path: "qrc:///Assets/Influences-Through-the-Ages",
            speed: 3
        },
    ]

    property string currentStyleName: styles[0].name
    property string currentStylePath: styles[0].path

    function setStyleByName(name) {
        var hasStyle = styles.find(function (s) {
            return s.name === name;
        });
        if (hasStyle) {
            currentStyleName = hasStyle.name;
            currentStylePath = hasStyle.path;
        }
    }

    function getStyleName() {
        return currentStyleName;
    }

    function getStylePath() {
        return currentStylePath;
    }

    function getSpeed() {
        var style = styles.find(function (s) {
            return s.name === currentStyleName;
        });
        return style ? style.speed : 0;
    }
}
