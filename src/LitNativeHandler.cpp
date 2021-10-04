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
}

void LitNativeHandler::fillScreen(QWindow *window, QScreen *screen) {
    window->setGeometry(screen->availableVirtualGeometry());
}

void LitNativeHandler::centerInScreen(QWindow *window, QScreen *screen) {
    const QPoint screenCenter = screen->availableVirtualGeometry().center();
    const QSize windowSize = window->size();
    window->setPosition(screenCenter.x() - windowSize.width() / 2,
                        screenCenter.y() - windowSize.height() / 2);
}
