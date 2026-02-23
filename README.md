# Unignorable

A native macOS app that displays full-screen notifications triggered by URL schemes. Perfect for getting your attention when long-running tasks complete. It obviously ignores Focus Mode or similar setups.

https://github.com/user-attachments/assets/0e66b351-2cbe-4b29-8a88-d1d56f4e7f2f

## Quick Start

### Install

```bash
curl -sL https://github.com/breath103/unignorable/releases/latest/download/Unignorable.zip -o /tmp/Unignorable.zip
unzip -o /tmp/Unignorable.zip -d /Applications && xattr -cr /Applications/Unignorable.app
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
