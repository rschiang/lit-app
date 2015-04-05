import QtQuick 2.0
import QtQuick.Window 2.1

Window {
    id: window
    title: "Lit"
    visibility: Window.Hidden

    function open() {
        window.flags |= Qt.WindowDoesNotAcceptFocus
        window.show()
    }

    Text {
        anchors.fill: parent
        font.pixelSize: 72
        text: "Hello world"
    }
}
