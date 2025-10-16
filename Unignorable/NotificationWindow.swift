import Cocoa
import SwiftUI

class NotificationWindow: NSWindow {
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

        switch type {
        case .confetti:
            let confettiView = ConfettiView(onComplete: onComplete)
            self.contentView = NSHostingView(rootView: confettiView)
        }

        self.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    override var canBecomeKey: Bool {
        true
    }

    override var canBecomeMain: Bool {
        true
    }
}
