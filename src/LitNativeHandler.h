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
    Q_INVOKABLE void setScreen(QWindow* window, QScreen* screen);
    Q_INVOKABLE void fillScreen(QWindow* window, QScreen* screen);
    Q_INVOKABLE void centerInScreen(QWindow* window, QScreen* screen);

private:
    QGuiApplication* app;
};

#endif // LITNATIVEHANDLER_H
