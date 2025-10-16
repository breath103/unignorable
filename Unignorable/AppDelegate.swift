import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var notificationWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide the app from appearing in dock briefly
        NSApp.setActivationPolicy(.accessory)

        // Check for launch arguments (for debugging)
        let arguments = CommandLine.arguments
        if let typeIndex = arguments.firstIndex(of: "-t"),
           typeIndex + 1 < arguments.count,
           let notificationType = NotificationType(rawValue: arguments[typeIndex + 1]) {
            showNotification(type: notificationType)
        }
    }

    // Handle URLs when app is launched or already running
    func application(_ application: NSApplication, open urls: [URL]) {
        guard let url = urls.first else {
            NSApp.terminate(nil)
            return
        }

        handleURL(url)
    }

    func handleURL(_ url: URL) {
        // Parse the URL scheme
        guard url.scheme == "unignorable",
              let host = url.host(),
              let notificationType = NotificationType(rawValue: host) else {
            NSApp.terminate(nil)
            return
        }

        showNotification(type: notificationType)
    }

    func showNotification(type: NotificationType) {
        let window = NotificationWindow(type: type) {
            NSApp.terminate(nil)
        }
        self.notificationWindow = window
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
