import QtQuick 2.0

Item {
    id: item
    opacity: 0
    visible: false

    property int maxWidth: 0
    property int maxHeight: 0
    property double scaleRatio: 1.272006289 // 1.618 ** 0.5

    property int measuredWidth
    property int measuredHeight
    property int measuredSize

    signal measured

    Text {
        id: measurer
        renderType: Text.NativeRendering
    }

    Timer {
        id: timer
        interval: 50
        repeat: false
        running: false
        triggeredOnStart: false

        onTriggered: {
            var baseSize = (item.maxWidth > item.maxHeight ?
                                (item.maxHeight > 0 ? item.maxHeight : item.maxWidth) :
                                (item.maxWidth > 0 ? item.maxWidth : 0))

            if (baseSize > 0)
                do {
                    measurer.font.pixelSize = baseSize
                    baseSize = Math.floor(baseSize / item.scaleRatio)
                }
                while (measurer.paintedWidth >= item.maxWidth ||
                       measurer.paintedHeight >= item.maxHeight)

            item.measuredWidth = measurer.paintedWidth
            item.measuredHeight = measurer.paintedHeight
            item.measuredSize = baseSize

            item.measured()
        }
    }

    function measure(text) {
        if (item.maxWidth > 0 || item.maxHeight > 0) {
            measurer.width = text.width
            measurer.horizontalAlignment = text.horizontalAlignment
            measurer.wrapMode = text.wrapMode
        }

        measurer.font = text.font
        measurer.text = text.text

        timer.start()
    }
}
