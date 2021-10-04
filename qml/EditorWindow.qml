import QtQuick 2.2

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
            font.family: app.mode === "code" ? "Source Code Pro, Source Han Sans TC" : "Source Han Sans TC"
            font.weight: Font.DemiBold
            renderType: TextEdit.NativeRendering
            smooth: true

            focus: true
            selectByMouse: true

            onTextChanged: {
                app.text = text
            }

            function scrollToSelection() {
                var pos = cursorRectangle.y
                var delta = pos - flickable.contentY
                if (delta < 0)
                    flickable.contentY = pos
                else if (delta >= flickable.height)
                    flickable.contentY = Math.min(flickable.contentHeight, pos + cursorRectangle.height) - flickable.height
            }

            Keys.onPressed: (event) => {
                if (event.modifiers & Qt.ControlModifier)
                    switch (event.key) {
                    case Qt.Key_L:
                        app.mode = (app.mode == "code") ? "" : "code"
                        break
                    }
            }

            onSelectionStartChanged: scrollToSelection()
            onSelectionEndChanged: scrollToSelection()
        }
    }
}
