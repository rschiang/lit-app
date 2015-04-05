import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.1

Window {
    id: window
    title: "Lit"

    onWidthChanged: timer.start()
    onHeightChanged: timer.start()

    function init() {
        window.flags |= Qt.WindowStaysOnTopHint
        window.width = 400
        window.height = 300
        window.show()
    }

    onClosing: Qt.quit()

    property bool lightsOut: false
    color: lightsOut ? "#282828" : "#fff"

    TextEdit {
        id: editor
        anchors.fill: parent
        font.family: "Noto Sans T Chinese"
        font.weight: Font.DemiBold
        renderType: TextEdit.NativeRendering

        color: lightsOut ? "#f8f8f2" : "#222"
        selectionColor: lightsOut ? "#49483e" : "#4fc3f7"
        selectedTextColor: lightsOut ? "#f8f8f2" : "#333"

        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter
        textMargin: 0

        smooth: true
        focus: true
        selectByMouse: true

        onTextChanged: {
            app.text = text
            timer.start()
        }
        Keys.onPressed: timer.start()
        Keys.onReleased: timer.start()

        Behavior on font.pixelSize {
            SmoothedAnimation {
                duration: 50
                easing.type: Easing.InExpo
            }
        }
    }

    Text {
        id: measurer
        opacity: 0

        font.family: editor.font.family
        font.weight: editor.font.weight
        renderType: Text.NativeRendering

        textFormat: Text.PlainText
        width: editor.width
        wrapMode: editor.wrapMode
        text: editor.length > 0 ? editor.text : "Hello world."
    }

    Timer {
        id: timer
        interval: 50
        repeat: false
        running: false
        triggeredOnStart: false

        onTriggered: {
            var baseSize = Math.min(window.width, window.height);
            var ratio = 1.125;

            do {
                measurer.font.pixelSize = baseSize;
                baseSize = Math.floor(baseSize / ratio);
            } while (measurer.paintedWidth >= editor.width ||
                     measurer.paintedHeight >= editor.height)

            editor.font.pixelSize = baseSize;
        }
    }

    Action {
        text:"Lights Out Mode"
        shortcut: "Ctrl+L"
        onTriggered: {
            lightsOut = !lightsOut
        }
    }
}
