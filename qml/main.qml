import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id: window
    title: "Lit"
    x: 0
    y: 0
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    visible: true
    flags: Qt.Window | Qt.WindowFullscreenButtonHint

    onWidthChanged: timer.start()
    onHeightChanged: timer.start()

    TextEdit {
        id: editor
        anchors.fill: parent
        font.family: "思源黑體"
        font.weight: Font.DemiBold
        renderType: TextEdit.NativeRendering

        color: "#222"
        selectionColor: "#4fc3f7"
        selectedTextColor: "#333"

        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter
        textMargin: 0

        smooth: true
        focus: true
        selectByMouse: true

        onTextChanged: timer.start()
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
}
