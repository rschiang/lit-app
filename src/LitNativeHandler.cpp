#include "LitNativeHandler.h"

LitNativeHandler::LitNativeHandler(QGuiApplication* parent)
    : QObject(parent)
{
    this->app = parent;
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
