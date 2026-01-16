import Cocoa
import SwiftUI

class NotificationWindow: NSWindow {
    private var onComplete: (() -> Void)?

    convenience init(type: NotificationType, onComplete: @escaping () -> Void) {
        let screen = NSScreen.main ?? NSScreen.screens[0]

        self.init(
            contentRect: screen.frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false,
            screen: screen
        )

        self.level = .floating
        self.backgroundColor = .clear
        self.isOpaque = false
        self.ignoresMouseEvents = false
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        self.isRestorable = false

        switch type {
        case .confetti:
            let confettiView = ConfettiView(onComplete: onComplete)
            self.contentView = NSHostingView(rootView: confettiView)
        case .sunrise:
            let sunriseView = SunriseView(onComplete: onComplete)
            self.contentView = NSHostingView(rootView: sunriseView)
        }

        self.onComplete = onComplete
        self.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    override var canBecomeKey: Bool {
        true
    }

    override var canBecomeMain: Bool {
        true
    }

    override func mouseDown(with event: NSEvent) {
        onComplete?()
    }

    override func keyDown(with event: NSEvent) {
        if event.keyCode == 53 {
            onComplete?()
        } else {
            super.keyDown(with: event)
        }
    }
}
