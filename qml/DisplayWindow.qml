import QtQuick 2.0
import QtQuick.Window 2.1

Window {
    id: window
    title: "Lit"
    visible: true

    Text {
        id: label
        width: parent.width
        horizontalAlignment: TextEdit.AlignHCenter
        y: (parent.height - label.height) / 2

        lineHeight: textFormat == Text.RichText ? 0.85 : 1.15
        wrapMode: Text.NoWrap
        textFormat: Text.StyledText

        color: "#222"

        font.family: "Noto Sans T Chinese"
        font.weight: Font.DemiBold
        renderType: TextEdit.NativeRendering
        smooth: true

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
        renderType: Text.NativeRendering

        width: label.width
        horizontalAlignment: label.horizontalAlignment
        lineHeight: 1.25
        wrapMode: label.wrapMode
        textFormat: Text.StyledText
        font: label.font
        text: label.text
    }

    Timer {
        id: timer
        interval: 50
        repeat: false
        running: false
        triggeredOnStart: false

        onTriggered: {
            var baseSize = Math.min(window.width, window.height)
            var ratio = 1.125

            do {
                measurer.font.pixelSize = baseSize
                baseSize = Math.floor(baseSize / ratio)
            } while (measurer.paintedWidth >= window.width ||
                     measurer.paintedHeight >= window.height)

            label.font.pixelSize = baseSize
        }
    }

    Connections {
        target: app
        onTextChanged: {
            label.text = app.text
            // Workaround for inproper line height
            label.textFormat = app.text.indexOf('<code') >= 0 ? Text.RichText
                                                              : Text.StyledText
            timer.start()
        }
    }

    onWidthChanged: timer.start()
    onHeightChanged: timer.start()
    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }
}
