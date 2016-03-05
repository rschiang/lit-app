import QtQuick 2.5
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

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: editor.height

        TextEdit {
            id: editor
            width: parent.width
            wrapMode: Text.Wrap
            textFormat: TextEdit.PlainText

            color: "#222"
            selectionColor: "#4fc3f7"
            selectedTextColor: "#333"

            font.pixelSize: 24
            font.family: app.mode == "code" ? "Source Code Pro, Source Han Sans TC" : "Source Han Sans TC"
            font.weight: Font.DemiBold
            renderType: TextEdit.NativeRendering
            smooth: true

            focus: true
            selectByMouse: true

            onTextChanged: {
                app.text = (app.mode == "code") ? text : format(text)
            }

            function format(text) {
                return text
                    .replace(/\n*$/, '\n')
                    .replace(/[\d\D]+\n\n+(\S)/g, "$1")
                    .replace(/[<>&\n]/g, function(c) {
                        switch (c) {
                            case "&": return "&amp;"
                            case "<": return "&lt;"
                            case ">": return "&gt;"
                            case "\n": return "<br>"
                        }})
                    .replace(/`(.+)`/g, "<code style='font-family: Ubuntu Mono, monospace'>$1</code>")
                    .replace(/\*\*([^\n\*]+)\*\*/g, "<b>$1</b>")
                    .replace(/\*([^\s\n\*]+)\*/g, "*<i>$1</i>*")
                    .replace(/~~(.+)~~/g, "<s>$1</s>")
            }

            function scrollToSelection() {
                var pos = cursorRectangle.y
                var delta = pos - flickable.contentY
                if (delta < 0)
                    flickable.contentY = pos
                else if (delta >= flickable.height)
                    flickable.contentY = Math.min(flickable.contentHeight, pos + cursorRectangle.height) - flickable.height
            }

            Keys.onPressed: {
                if (event.modifiers & Qt.ControlModifier)
                    switch (event.key) {
                    case Qt.Key_L:
                        app.mode = (app.mode == "code") ? "" : "code"
                        break
                    }
                if (event.key === Qt.Key_Return && app.mode == "code") {
                    var lineStart = text.lastIndexOf('\n', selectionStart - 1) + 1

                    // Insert all spaces at the start of line
                    for (var i = lineStart; i < selectionStart; i++)
                        if (text[i] != " ") {
                            insert(selectionEnd + 1, new Array(i - lineStart + 1).join(" "))
                            console.log(selectionEnd + ', ' + length)
                            break
                        }
                }
            }

            onSelectionStartChanged: scrollToSelection()
            onSelectionEndChanged: scrollToSelection()
        }
    }
}
