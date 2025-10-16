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
