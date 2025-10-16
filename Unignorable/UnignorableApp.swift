//
//  UnignorableApp.swift
//  Unignorable
//
//  Created by Kurt Lee on 2025-10-16.
//

import SwiftUI

@main
struct UnignorableApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // No default window - app only runs when triggered by URL
        Settings {
            EmptyView()
        }
    }
}
