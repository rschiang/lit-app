import QtQuick 2.0
import QtQuick.Window 2.1

Window {
    id: window
    title: "Lit"
    visible: true
    color: app.mode == "code" ? "#272822" : "#fff"

    Text {
        id: label
        width: parent.width
        horizontalAlignment: app.mode == "code" ? TextEdit.AlignLeft : TextEdit.AlignHCenter
        y: (parent.height - label.height) / 2

        lineHeight: textFormat == Text.RichText ? 0.85 : 1.15
        wrapMode: Text.NoWrap
        textFormat: Text.StyledText

        color: app.mode == "code" ? "#f8f8f2" : "#222"

        font.family: app.mode == "code" ? "Ubuntu Mono, Noto Sans T Chinese" : "Noto Sans T Chinese"
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
        textFormat: app.mode == "code" ? Text.PlainText : Text.StyledText
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
            // Workaround for inproper line height
            var format = app.mode == "code" ? Text.PlainText
                                            : app.text.indexOf('<') >= 0 ? Text.RichText
                                                                         : Text.StyledText
            if (label.textFormat !== format)
                label.textFormat = format
            label.text = app.text
            timer.start()
        }
    }

    onWidthChanged: timer.start()
    onHeightChanged: timer.start()
    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }
}
