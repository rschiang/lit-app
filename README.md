Lit
===

Lit is a Qt-based application aimed to make live text projecting like a breeze.

Targets Qt 5.4 or higher.

Supported syntaxes
------------------
```
*italics*
**bold text**
`code segments`
~~strikethrough~~
```

Installation
------------------
1. `$ brew install qt5`
2. `$ brew linkapps qt5`
3.  Comment Line 21 in Lit.pro (I am using 10.11.1)
   `#    QMAKE_MAC_SDK = macosx10.9`
4. `$ /usr/local/opt/qt5/bin/qmake -spec macx-xcode Lit.pro`
5. Open project by Xcode.
6. cmd + R to run project.
7. Modify qml files, rerun step 6.

https://github.com/rschiang/lit-app
