import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.1

Window {
    id: window
    title: "Lit"

    function init() {
        window.flags |= Qt.WindowStaysOnTopHint
        window.width = 400
        window.height = 300
        window.show()
    }

    onClosing: Qt.quit()

    TextEdit {
        id: editor
        anchors.fill: parent
        horizontalAlignment: TextEdit.AlignHCenter
        textMargin: 0
        wrapMode: TextEdit.Wrap

        color: "#222"
        selectionColor: "#4fc3f7"
        selectedTextColor: "#333"

        font.pixelSize: 36
        font.family: "Noto Sans T Chinese"
        font.weight: Font.DemiBold
        renderType: TextEdit.NativeRendering
        smooth: true

        focus: true
        selectByMouse: true

        onTextChanged: {
            app.text = text
        }
    }
}
