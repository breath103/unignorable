//
//  AppDelegate.swift
//  Unignorable
//
//  Created by Kurt Lee on 2025-10-16.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var notificationWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide the app from appearing in dock briefly
        NSApp.setActivationPolicy(.accessory)
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
        if url.scheme == "unignorable" {
            let notificationType = url.host() ?? ""
            showNotification(type: notificationType)
        } else {
            NSApp.terminate(nil)
        }
    }

    func showNotification(type: String) {
        switch type {
        case "confetti":
            showConfetti()
        default:
            NSApp.terminate(nil)
        }
    }

    func showConfetti() {
        // Create a full-screen transparent window
        let screen = NSScreen.main ?? NSScreen.screens[0]
        let window = NSWindow(
            contentRect: screen.frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false,
            screen: screen
        )

        window.level = .floating
        window.backgroundColor = .clear
        window.isOpaque = false
        window.ignoresMouseEvents = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

        let confettiView = ConfettiView {
            // Called when animation completes
            window.close()
            NSApp.terminate(nil)
        }

        window.contentView = NSHostingView(rootView: confettiView)
        window.makeKeyAndOrderFront(nil)

        self.notificationWindow = window
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
