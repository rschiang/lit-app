import QtQuick 2.0
import QtQuick.Window 2.1

Window {
    id: window
    title: "Lit"
    visible: true

    Text {
        anchors.fill: parent
        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter

        font.pixelSize: 72
        text: app.text
    }

    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }
}
