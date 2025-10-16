# Unignorable

A native macOS app that displays full-screen notifications triggered by URL schemes.

## Development Guidelines

- **NO Claude attribution**: Do not add "Generated with Claude Code" or "Co-Authored-By: Claude" in commits or PRs
- **NO file headers**: Do not add file header comments (e.g., `// Created by...`, `// Filename.swift`, etc.)
- Keep commit messages clean and professional

## Overview

Unignorable is a simple, single-purpose macOS application that:
- Responds to custom URL scheme triggers (e.g., `unignorable://confetti`)
- Displays full-screen notification animations
- Automatically terminates after showing the notification

## Features

### URL Scheme Handler
- Custom URL scheme: `unignorable://`
- Supports different notification types via path component
- Currently implemented: `unignorable://confetti`

### Notification Types
- **Confetti**: Full-screen confetti animation celebration effect

### App Behavior
- Launches on-demand when URL is triggered
- Shows single-screen notification overlay
- Automatically quits after notification completes
- No persistent UI or menu bar presence

## Architecture

### Components
1. **AppDelegate**: Handles URL events and app lifecycle
2. **NotificationWindow**: Full-screen transparent window for effects
3. **ConfettiView**: SwiftUI view with confetti particle animation
4. **NotificationCoordinator**: Manages notification display and app termination

## Project Structure

```
Unignorable/
├── UnignorableApp.swift          # Main app entry point
├── AppDelegate.swift             # URL scheme handler
├── NotificationWindow.swift      # Full-screen window
├── Views/
│   └── ConfettiView.swift       # Confetti animation
├── Models/
│   └── NotificationType.swift   # Notification type enum
└── Info.plist                    # URL scheme configuration
```

## Usage

Trigger the confetti notification:
```bash
open "unignorable://confetti"
```

## Requirements

- macOS 13.0+
- Xcode 14.0+
- Swift 5.7+

## Future Enhancements

- Additional notification types (alerts, celebrations, reminders)
- Customizable animation duration
- Sound effects
- Configuration options via URL parameters
