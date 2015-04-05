#include "LitNativeHandler.h"

LitNativeHandler::LitNativeHandler(QGuiApplication* parent)
    : QObject(parent)
{
    this->app = parent;
}

QVariantList LitNativeHandler::getScreens() {
    QVariantList screens;
    foreach (QScreen* screen, QGuiApplication::screens()) {
        screens << QVariant::fromValue(screen);
        QQmlEngine::setObjectOwnership(screen, QQmlEngine::CppOwnership);
    }
    return screens;
}

QScreen* LitNativeHandler::getPrimaryScreen() {
    return QGuiApplication::primaryScreen();
}

void LitNativeHandler::setScreen(QWindow *window, QScreen *screen) {
    window->setScreen(screen);
    window->setGeometry(screen->availableGeometry());
}
