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

    TextEdit {
        id: editor
        anchors.fill: parent
        font.family: "思源黑體"
        font.weight: Font.DemiBold
        renderType: TextEdit.NativeRendering

        color: "#222"
        selectionColor: "#4fc3f7"
        selectedTextColor: "#333"

        //horizontalAlignment: TextEdit.AlignHCenter
        //verticalAlignment: TextEdit.AlignVCenter
        textMargin: 0

        smooth: true
        focus: true

        onTextChanged: {
            var baseSize = 16;
            var ratio = 1.125;
            editor.font.pixelSize = 128; return;

            do {
                measurer.font.pixelSize = baseSize;
                if (measurer.paintedWidth <= window.width &&
                    measurer.paintedHeight <= window.height)
                    baseSize = Math.floor(baseSize * ratio);
                else break;
            } while (baseSize < window.height)

            editor.font.pixelSize = measurer.font.pixelSize;
        }
    }

    Text {
        id: measurer
        opacity: 0
        font.family: editor.font.family
        font.weight: editor.font.weight
        text: editor.length > 0 ? editor.text : "A"
    }
}
