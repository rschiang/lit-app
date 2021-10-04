import QtQuick 6.0

Window {
    id: window
    title: "Lit"

    width: 540
    height: 320
    color: app.theme === "dark" ? "#1e1e1e" : "#fff"

    Component.onCompleted: {
        window.flags |= Qt.WindowStaysOnTopHint
    }

    onClosing: Qt.quit()

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: editor.height

        TextEdit {
            id: editor
            width: parent.width
            padding: 8

            wrapMode: Text.Wrap
            textFormat: TextEdit.PlainText

            color: app.theme === "dark" ? "#fff" : "#222"
            selectionColor: app.theme === "dark" ? "#3f638b" : "#4fc3f7"
            selectedTextColor: app.theme === "dark" ? "#fff" : "#333"

            font.pixelSize: 24
            font.family: app.mode === "code" ? "Source Code Pro, Source Han Sans TC" : "Source Sans Pro, Source Han Sans TC"
            font.weight: Font.Medium
            renderType: TextEdit.NativeRendering
            smooth: true

            focus: true
            selectByMouse: true

            function scrollToSelection() {
                var pos = cursorRectangle.y
                var delta = pos - flickable.contentY
                if (delta < 0)
                    flickable.contentY = pos
                else if (delta >= flickable.height)
                    flickable.contentY = Math.min(flickable.contentHeight, pos + cursorRectangle.height) - flickable.height
            }

            onTextChanged: app.text = text

            Keys.onPressed: (event) => {
                if (event.modifiers & Qt.ControlModifier)
                    switch (event.key) {
                    case Qt.Key_D:
                        app.theme = (app.theme === "dark") ? "light" : "dark"
                        break
                    case Qt.Key_L:
                        app.mode = (app.mode === "code") ? "" : "code"
                        break
                    }
            }

            onSelectionStartChanged: scrollToSelection()
            onSelectionEndChanged: scrollToSelection()
        }
    }
}
