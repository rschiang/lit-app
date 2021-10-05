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

void LitNativeHandler::fillScreen(QWindow *window, QScreen *screen) {
    window->setGeometry(screen->availableVirtualGeometry());
}

void LitNativeHandler::alignAtScreen(QWindow *window, QScreen *screen) {
    const QPoint screenCorner = screen->availableVirtualGeometry().bottomRight();
    const QSize windowSize = window->size();
    window->setPosition(screenCorner.x() - windowSize.width(),
                        screenCorner.y() - windowSize.height());
}
