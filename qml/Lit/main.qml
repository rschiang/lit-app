import QtQuick 2.0

Rectangle {

    TextEdit {
        anchors.fill: parent
        font.family: "思源黑體"
        font.weight: Font.DemiBold
        font.pixelSize: parent.width / Math.max(length, 4)
        renderType: TextEdit.NativeRendering
        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter
        smooth: true
        focus: true
    }
}
