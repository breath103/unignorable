# Unignorable

A native macOS app that displays full-screen notifications triggered by URL schemes. Perfect for getting your attention when long-running tasks complete.

## Supported URLs

- `unignorable://confetti` - Full-screen confetti celebration animation

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

Add this to your Claude Code settings to get notified when Claude needs your input:

**~/.claude/settings.json:**
```json
{
  "hooks": {
    "userPromptSubmit": "open 'unignorable://confetti' &"
  }
}
```

Or notify when tasks complete:

```json
{
  "hooks": {
    "afterToolCall": "open 'unignorable://confetti' &"
  }
}
```

## Installation

1. Open `Unignorable.xcodeproj` in Xcode
2. Add URL Type in **Project > Target > Info > URL Types**:
   - URL Schemes: `unignorable`
   - Identifier: `com.unignorable.urlscheme`
3. Build and run (⌘B then ⌘R)
4. App is now ready to receive notifications

See [SETUP.md](SETUP.md) for detailed instructions.

## Use Cases

- Get notified when CI/CD pipelines complete
- Alert when long build processes finish
- Celebrate when tests pass
- Get attention when AI assistants need input
- Any automation that needs to break through focus mode

## License

MIT
