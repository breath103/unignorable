# Unignorable

A native macOS app that displays full-screen notifications triggered by URL schemes. Perfect for getting your attention when long-running tasks complete.

## Supported URLs

- `unignorable://confetti` - Full-screen confetti celebration animation  

https://github.com/user-attachments/assets/64495a42-1321-475f-8703-e832fc72e722

## How to Trigger

From Terminal or any script:

```bash
open "unignorable://confetti"
```

From code:

```swift
// Swift
NSWorkspace.shared.open(URL(string: "unignorable://confetti")!)
```

```javascript
// Node.js
const { exec } = require('child_process');
exec('open "unignorable://confetti"');
```

```python
# Python
import subprocess
subprocess.run(['open', 'unignorable://confetti'])
```

## Using with Claude Code

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

## Architecture

Unignorable is designed to be lightweight and ephemeral:

- **Single-window overlay**: Creates a full-screen transparent window on top of all other applications
- **On-demand execution**: App only runs when triggered by a URL scheme
- **Auto-termination**: Immediately quits after the notification animation completes (~3 seconds)
- **No persistent UI**: No dock icon, no menu bar, no background processes

This design ensures the app has zero overhead when not in use and provides truly unignorable notifications when needed.

## Installation

1. Open `Unignorable.xcodeproj` in Xcode
2. Build and run (⌘R)
3. App is now ready to receive notifications

That's it! The URL scheme is already configured in the project.

## Use Cases

- Get notified when CI/CD pipelines complete
- Alert when long build processes finish
- Celebrate when tests pass
- Get attention when AI assistants need input
- Any automation that needs to break through focus mode

## License

MIT
