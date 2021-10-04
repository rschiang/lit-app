#include <AppKit/AppKit.h>
#include "LitNativeHandler.h"

void LitNativeHandler::makeWindowTitleBarTransparent(QWindow* qWindow) {
    NSView *view = (NSView *) reinterpret_cast<void *>(qWindow->winId());
    NSWindow *window = view.window;
    window.styleMask |= NSWindowStyleMaskFullSizeContentView;
    window.titlebarAppearsTransparent = YES;
}
