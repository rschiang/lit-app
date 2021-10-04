import QtQuick 6.0

Window {
    id: window
    title: "Lit"
    color: app.mode === "code" ? "#272822" : "#fff"

    Text {
        id: label

        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            margins: 8
        }
        horizontalAlignment: app.mode === "code" ? TextEdit.AlignLeft : TextEdit.AlignHCenter

        lineHeight: 0.85
        wrapMode: Text.NoWrap
        textFormat: app.mode === "code" ? Text.PlainText : Text.RichText

        color: app.mode === "code" ? "#f8f8f2" : "#222"

        font.family: app.mode === "code" ? "Source Code Pro, Source Han Sans TC" : "Source Han Sans TC"
        font.weight: Font.DemiBold
        renderType: TextEdit.NativeRendering
        smooth: true

        text: app.mode === "code" ? app.text : format(app.text)

        Behavior on font.pixelSize {
            SmoothedAnimation {
                duration: 50
                easing.type: Easing.InExpo
            }
        }

        function format(text) {
            return text
                .replace(/\n+$/, '\n')
                .replace(/[\d\D]+\n\n+(\S)/g, "$1")
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace(/`(.+)`/g, "<code style='font-family: Ubuntu Mono, monospace'>$1</code>")
                .replace(/\*\*([^\n\*]+)\*\*/g, "<b>$1</b>")
                .replace(/\*([^\s\n\*]+)\*/g, "*<i>$1</i>*")
                .replace(/~~(.+)~~/g, "<s>$1</s>")
                .replace("\n", "<br>")
        }
    }

    Text {
        id: measurer
        opacity: 0
        renderType: Text.NativeRendering
        antialiasing: false

        width: label.width
        horizontalAlignment: label.horizontalAlignment
        lineHeight: label.lineHeight
        wrapMode: label.wrapMode
        textFormat: label.textFormat
        font.family: label.font.family
        font.weight: label.font.weight
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

            let size = measurer.font.pixelSize
            label.font.pixelSize = size
            label.font.letterSpacing = size * -0.025
        }
    }

    Connections {
        target: app

        function onTextChanged() { timer.start() }
        function onModeChanged() { timer.start() }
    }

    onWidthChanged: timer.start()
    onHeightChanged: timer.start()
    onScreenChanged: Native.fillScreen(window, screen)
    onWindowStateChanged: Native.makeWindowTitleBarTransparent(window)
    onVisibilityChanged: Native.makeWindowTitleBarTransparent(window)
    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }
}
