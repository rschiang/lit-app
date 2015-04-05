#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <LitNativeHandler.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("Lit");
    app.setOrganizationName("litapp");
    app.setOrganizationDomain("litapp.com");

    LitNativeHandler native(&app);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Native", &native);
    engine.load(QUrl("qrc:/qml/main.qml"));

    return app.exec();
}
