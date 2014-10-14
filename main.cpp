#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/Lit/main.qml"));
    viewer.setTitle("Lit");
    viewer.setFlags(viewer.flags() | Qt::WindowFullscreenButtonHint);
    viewer.setBaseSize(QSize(1024, 768));
    viewer.showExpanded();
    viewer.setWindowState(Qt::WindowMaximized);

    return app.exec();
}
