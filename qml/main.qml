import QtQuick 2.0

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
        var screens = Native.getScreens()
        var primaryScreen = Native.getPrimaryScreen()

        for (var i = 0; i < screens.length; i++)
            if (screens[i] != primaryScreen)
                spawn(screens[i])

        var editor = spawn(primaryScreen, editorPrototype)
        editor.init()
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
