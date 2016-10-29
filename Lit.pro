TEMPLATE = app
TARGET = Lit
QT += qml quick

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += \
    src/main.cpp \
    src/LitNativeHandler.cpp

HEADERS += \
    src/LitNativeHandler.h

RESOURCES += \
    main.qrc

OTHER_FILES += qml/*.qml

mac {
    QMAKE_INFO_PLIST = platform/mac/Info.plist
    ICON = platform/mac/icon.icns

    CONFIG(build_release) {
        # qmldir must match project folder name
        QMAKE_POST_LINK += macdeployqt Lit.app -qmldir=../lit-app/qml/ -verbose=1 -dmg;
    }
}
