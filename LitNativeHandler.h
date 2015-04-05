#ifndef LITNATIVEHANDLER_H
#define LITNATIVEHANDLER_H

#include <QObject>
#include <QWindow>
#include <QScreen>
#include <QJSEngine>
#include <QQmlEngine>
#include <QGuiApplication>

class LitNativeHandler : public QObject
{
    Q_OBJECT
public:
    explicit LitNativeHandler(QGuiApplication* parent);
    Q_INVOKABLE void enumerateScreen(QJSValue callback);
    Q_INVOKABLE QScreen* getPrimaryScreen();
    Q_INVOKABLE void setScreen(QWindow* window, QScreen* screen);

private:
    QGuiApplication* app;
};

#endif // LITNATIVEHANDLER_H
