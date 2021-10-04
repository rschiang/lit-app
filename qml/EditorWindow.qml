import QtQuick 6.0
import QtQuick.Controls 6.0

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

    ScrollView {
        id: scrollView
        anchors.fill: parent

        TextArea {
            id: editor

            wrapMode: Text.Wrap
            textFormat: TextEdit.PlainText

            font.pixelSize: 24
            font.family: app.mode === "code" ? "Source Code Pro, Source Han Sans TC" : "Source Sans Pro, Source Han Sans TC"
            font.weight: Font.Medium
            renderType: TextEdit.NativeRendering
            smooth: true

            focus: true
            selectByMouse: true

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
        }
    }

    Label {
        id: hint
        anchors {
            left: parent.left
            bottom: parent.bottom
            margins: 8
        }
        visible: (editor.text.length === 0)

        opacity: 0.45
        renderType: Text.NativeRendering
        textFormat: TextEdit.PlainText

        text: "Type to project text. Move to next screen with two line breaks.\n" +
              "⌘-D: Dark Mode  ⌘-L: Plain Text Mode (turn off markdown formatting)"

        onVisibleChanged: {
            if (editor.text.length > 0)
                hint.visible = false  // Disconnecting the property, Make hint display only once.
        }
    }
}
