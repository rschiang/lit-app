import QtQuick 6.0

QtObject {
    id: app

    // Properties
    property string text
    property string theme
    property string mode

    // Function
    function spawnDisplayWindow(screen) {
        let window = windowPrototype.createObject(app)
        window.screen = screen
        Native.fillScreen(window, screen)

        window.show()
        window.raise()
        return window
    }

    // Events
    Component.onCompleted: {
        const screens = Native.getScreens()
        const primaryScreen = Native.getPrimaryScreen()

        if (screens.length < 2)
            spawnDisplayWindow(screens[0])
        else
            for (let screen of screens)
                if (screen !== primaryScreen)
                    spawnDisplayWindow(screen)

        let editor = editorPrototype.createObject(app)
        editor.screen = primaryScreen
        Native.alignAtScreen(editor, primaryScreen)
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
