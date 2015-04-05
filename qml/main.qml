import QtQuick 2.0

QtObject {
    id: app

    // Properties
    property string text
    property string theme
    property string mode

    // Functions
    function spawn(screen) {
        var window = windowPrototype.createObject(app)
        Native.setScreen(window, screen)
        window.open()

        return window
    }

    // Events
    Component.onCompleted: {
        Native.enumerateScreen(spawn)

        var primaryScreen = Native.getPrimaryScreen()
        var editor = editorPrototype.createObject(app)
        Native.setScreen(editor, primaryScreen)
        editor.open()
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
