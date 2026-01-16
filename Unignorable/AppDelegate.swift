import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var notificationWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Disable window restoration
        NSWindow.allowsAutomaticWindowTabbing = false
        UserDefaults.standard.set(false, forKey: "NSQuitAlwaysKeepsWindows")

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
        guard let url = urls.first else { return }
        handleURL(url)
    }

    func handleURL(_ url: URL) {
        guard url.scheme == "unignorable" || url.scheme == "unignorable-debug",
              let host = url.host(),
              let notificationType = NotificationType(rawValue: host) else {
            return
        }

        showNotification(type: notificationType)
    }

    func showNotification(type: NotificationType) {
        notificationWindow?.close()
        notificationWindow = nil

        let window = NotificationWindow(type: type) { [weak self] in
            self?.notificationWindow?.close()
            self?.notificationWindow = nil
        }
        self.notificationWindow = window
    }

    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let menu = NSMenu()

        let confettiItem = NSMenuItem(title: "Confetti", action: #selector(triggerConfetti), keyEquivalent: "")
        confettiItem.target = self
        menu.addItem(confettiItem)

        let sunriseItem = NSMenuItem(title: "Sunrise", action: #selector(triggerSunrise), keyEquivalent: "")
        sunriseItem.target = self
        menu.addItem(sunriseItem)

        return menu
    }

    @objc func triggerConfetti() {
        showNotification(type: .confetti)
    }

    @objc func triggerSunrise() {
        showNotification(type: .sunrise)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return false
    }

    func applicationWillTerminate(_ notification: Notification) {
        notificationWindow?.close()
        notificationWindow = nil
    }

    func application(_ application: NSApplication, willEncodeRestorableState coder: NSCoder) {
        // Don't encode anything
    }

    func application(_ application: NSApplication, didDecodeRestorableState coder: NSCoder) {
        // Don't restore anything
    }
}
