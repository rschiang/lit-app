import QtQuick 6.0

QtObject {
    id: app

    // Properties
    property string text
    property string theme
    property string mode

    // Functions
    function spawn(screen, proto) {
        if (!proto)
            proto = windowPrototype

        var window = proto.createObject(app)
        Native.setScreen(window, screen)

        return window
    }

    // Events
    Component.onCompleted: {
        const screens = Native.getScreens()
        const primaryScreen = Native.getPrimaryScreen()

        if (screens.length >= 2) {
            for (let screen of screens) {
                if (screen !== primaryScreen) {
                    let window = spawn(screen)
                    Native.fillScreen(window, screen)
                    window.show()
                    window.raise()
                }
            }
        } else {
            let window = spawn(primaryScreen)
            Native.fillScreen(window, primaryScreen)
            window.show()
            window.raise()
        }

        let editor = spawn(primaryScreen, editorPrototype)
        Native.centerInScreen(editor, primaryScreen)
        editor.show()
    }

    // Resources
    property list<Component> resources: [
        Component {
            id: windowPrototype
            DisplayWindow {}
        },
        Component {
            id: editorPrototype
            EditorWindow {}
        }
    ]
}
