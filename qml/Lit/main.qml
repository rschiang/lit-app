import QtQuick 2.0

Rectangle {

    TextEdit {
        id: editor
        anchors.fill: parent
        font.family: "思源黑體"
        font.weight: Font.DemiBold
        renderType: TextEdit.NativeRendering
        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter
        smooth: true
        focus: true

        onTextChanged: {
            var baseSize = 16;
            var ratio = 1.125;

            do {
                measurer.font.pixelSize = baseSize;
                baseSize = Math.floor(baseSize * ratio);
            } while (measurer.paintedWidth <= parent.width &&
                     measurer.paintedHeight <= parent.height)
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
