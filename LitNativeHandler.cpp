#include "LitNativeHandler.h"

LitNativeHandler::LitNativeHandler(QGuiApplication* parent)
    : QObject(parent)
{
    this->app = parent;
}

void LitNativeHandler::enumerateScreen(QJSValue callback) {
    foreach (QScreen* screen, QGuiApplication::screens()) {
        QJSValue wrapper = callback.engine()->newQObject(screen);
        QQmlEngine::setObjectOwnership(screen, QQmlEngine::CppOwnership);
        callback.call(QJSValueList() << wrapper);
    }
}

QScreen* LitNativeHandler::getPrimaryScreen() {
    return QGuiApplication::primaryScreen();
}

void LitNativeHandler::setScreen(QWindow *window, QScreen *screen) {
    window->setScreen(screen);
    window->setGeometry(screen->availableGeometry());
}
