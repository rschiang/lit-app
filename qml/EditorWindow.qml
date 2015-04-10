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
        wrapMode: Text.Wrap

        color: "#222"
        selectionColor: "#4fc3f7"
        selectedTextColor: "#333"

        font.pixelSize: 24
        font.family: "Noto Sans T Chinese"
        font.weight: Font.DemiBold
        renderType: TextEdit.NativeRendering
        smooth: true

        focus: true
        selectByMouse: true

        onTextChanged: {
            app.text = format(text)
        }

        function format(text) {
            return text
                .replace(/[<>&\n]/g, function(c) {
                    switch (c) {
                        case "&": return "&amp;"
                        case "<": return "&lt;"
                        case ">": return "&gt;"
                        case "\n": return "<br>"
                    }})
                .replace(/`(.+)`/g, "<code style='font-family: Source Code Pro, monospace'>$1</code>")
                .replace(/\*\*([^\n\*]+)\*\*/g, "<b>$1</b>")
                .replace(/\*([^\s\n\*]+)\*/g, "*<i>$1</i>*")
                .replace(/~~(.+)~~/g, "<s>$1</s>")
        }
    }
}
