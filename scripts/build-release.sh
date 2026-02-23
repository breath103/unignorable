#!/bin/bash
set -e

osascript -e 'quit app "Unignorable"' 2>/dev/null || pkill Unignorable 2>/dev/null || true
sleep 0.5

xcodebuild -scheme Unignorable -configuration Release \
    CODE_SIGN_IDENTITY="-" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO \
    URL_SCHEME=unignorable \
    -derivedDataPath build \
    2>&1 | grep -E "(error:|warning:|BUILD)" | tail -10

cp -R build/Build/Products/Release/Unignorable.app /Applications/

# Re-register with Launch Services
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f /Applications/Unignorable.app

echo "Installed. Testing..."
sleep 1
open /Applications/Unignorable.app
sleep 1
open "unignorable://confetti"
