# Unignorable Setup Instructions

## Configure URL Scheme in Xcode

To enable the `unignorable://` URL scheme, follow these steps:

1. Open `Unignorable.xcodeproj` in Xcode
2. Select the **Unignorable** project in the navigator
3. Select the **Unignorable** target
4. Go to the **Info** tab
5. Expand **URL Types** section
6. Click the **+** button to add a new URL Type
7. Configure as follows:
   - **Identifier**: `com.unignorable.urlscheme`
   - **URL Schemes**: `unignorable`
   - **Role**: `Editor`

## Build and Run

1. Build the project (Cmd+B)
2. Run the app (Cmd+R)
3. The app will launch but show no window (this is normal)
4. Test by running in Terminal:
   ```bash
   open "unignorable://confetti"
   ```

## How It Works

- The app is designed to be **invisible by default**
- It only shows UI when triggered via URL scheme
- After displaying the notification, it **automatically quits**
- No menu bar icon, no dock icon (after proper configuration)

## Optional: Hide Dock Icon

To prevent the app from showing in the Dock when launched:

1. In Xcode, select the **Unignorable** project
2. Go to the **Info** tab
3. Add a new property:
   - **Key**: `Application is agent (UIElement)` (or `LSUIElement`)
   - **Type**: Boolean
   - **Value**: YES

This makes the app run as a background agent with no dock presence.

## Testing

Test the confetti notification:
```bash
open "unignorable://confetti"
```

You should see a full-screen confetti animation that automatically closes after ~3 seconds.
