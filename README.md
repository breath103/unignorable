# Unignorable

A native macOS app that displays full-screen notifications triggered by URL schemes. Perfect for getting your attention when long-running tasks complete. It obviously ignores Focus Mode or similar setups.

https://github.com/user-attachments/assets/0e66b351-2cbe-4b29-8a88-d1d56f4e7f2f

## Quick Start

### Install

Download `Unignorable.zip` from the [latest release](https://github.com/breath103/unignorable/releases/latest), unzip, and move `Unignorable.app` to `/Applications`.

Since the app is not notarized, macOS will block it on first launch. To allow it:
1. Right-click `Unignorable.app` → **Open**
2. Click **Open** in the dialog that appears

You only need to do this once. After that, URL scheme triggers will work normally.

Or build from source:
```bash
xcodebuild -scheme Unignorable -configuration Release \
  CODE_SIGN_IDENTITY="-" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO \
  URL_SCHEME=unignorable -derivedDataPath build
cp -R build/Build/Products/Release/Unignorable.app /Applications/
```

### Trigger

```bash
open "unignorable://confetti"
```

### Claude Code Setup

Add this to your Claude Code settings to get confetti when Claude finishes responding:

**~/.claude/settings.json:**
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "open 'unignorable://confetti' &"
          }
        ]
      }
    ]
  }
}
```


## Features

- `unignorable://confetti` - Full-screen confetti celebration animation
- `unignorable://sunrise` - Sunrise notification animation


----

## Architecture

Unignorable is designed to be lightweight and ephemeral:

- **Single-window overlay**: Creates a full-screen transparent window on top of all other applications
- **On-demand execution**: App only runs when triggered by a URL scheme
- **Auto-termination**: Immediately quits after the notification animation completes (~3 seconds)
- **No persistent UI**: No dock icon, no menu bar, no background processes

This design ensures the app has zero overhead when not in use and provides truly unignorable notifications when needed.

## License

MIT
