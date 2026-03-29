pragma Singleton
import QtQuick

QtObject {
    id: snakeStyle

    readonly property var styles: [
        {
        name : "Eternal Ceremony",
        path : "qrc:///Assets/Eternal-Ceremony"
        },
        {
        name :"Influences-Through-the-Ages",
        path : "qrc:///Assets/Influences-Through-the-Ages"
        },
    ]

    property string currentStyleName: styles[0].name
    property string currentStylePath: styles[0].path

    function setStyleByName(name) {
        var hasStyle = styles.find(function(s) { return s.name === name; });
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
}