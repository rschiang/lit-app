#ifndef LITNATIVEHANDLER_H
#define LITNATIVEHANDLER_H

#include <QObject>
#include <QWindow>
#include <QScreen>
#include <QQmlEngine>
#include <QGuiApplication>

class LitNativeHandler : public QObject
{
    Q_OBJECT
public:
    explicit LitNativeHandler(QGuiApplication* parent);
    Q_INVOKABLE QVariantList getScreens();
    Q_INVOKABLE QScreen* getPrimaryScreen();
    Q_INVOKABLE void fillScreen(QWindow* window, QScreen* screen);
    Q_INVOKABLE void alignAtScreen(QWindow* window, QScreen* screen);
    Q_INVOKABLE void makeWindowTitleBarTransparent(QWindow* window);

private:
    QGuiApplication* app;
};

#endif // LITNATIVEHANDLER_H
