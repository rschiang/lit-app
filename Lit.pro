TEMPLATE = app
TARGET = Lit
QT += qml quick

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

OTHER_FILES += qml/*.qml

mac {
    QMAKE_MAC_SDK = macosx10.9
}

RESOURCES += \
    main.qrc
