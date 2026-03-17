# Global Constraints

These rules apply to ALL projects. Every Claude Code instance must follow them. They are non-negotiable.

## Hardware

- **8GB RAM total** on the host Mac. Never run more than 2 Claude Code instances simultaneously.
- Kill idle Claude instances when switching projects.

## Simulators

- **NEVER run the iOS Simulator.** It eats RAM and is not needed for CLI-based work.
- Use `xcodebuild build` to verify compilation, not `xcodebuild run`.
- For React Native (pkmn-btl-sim), use `npx expo start` only when explicitly asked.

## TestFlight Deployment

**Deployment MUST always be done via CLI. Never suggest using Xcode GUI. Always archive, export, and upload automatically.**

Deployment is the most failure-prone part of the workflow. Follow these steps exactly and handle errors automatically — don't bail out and tell the user to do it manually.

### Before ANY deployment

1. Run all tests first
2. Increment build number
3. Commit the version bump
4. Tag the commit: `git tag -a v<version>-b<build> -m "TestFlight build <build>"`

### SwiftUI projects (goDealApp, AbsolutelyNot)

Each project has an `ExportOptions.plist` configured for App Store Connect. Run the full pipeline — clean, archive, export, upload — in one go.

```bash
# Full pipeline — run all steps automatically
SCHEME="<SCHEME>"

# 1. Clean
xcodebuild clean -scheme "$SCHEME" -configuration Release

# 2. Archive
xcodebuild archive \
  -scheme "$SCHEME" \
  -configuration Release \
  -archivePath ./build/"$SCHEME".xcarchive \
  -destination 'generic/platform=iOS' \
  CODE_SIGN_IDENTITY="Apple Distribution" \
  CODE_SIGN_STYLE=Manual

# 3. Export IPA
xcodebuild -exportArchive \
  -archivePath ./build/"$SCHEME".xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath ./build/export

# 4. Upload to App Store Connect (automatically)
xcrun altool --upload-app \
  -f ./build/export/"$SCHEME".ipa \
  -t ios \
  -u <APPLE_ID> \
  -p <APP_SPECIFIC_PASSWORD>
```

**If a step fails, diagnose and fix it — do not stop and ask the user to do it in Xcode.**

Common failures and how to fix them:
- Signing errors → check `CODE_SIGN_IDENTITY` matches provisioning profile, try `CODE_SIGN_STYLE=Automatic` as fallback
- "No accounts with App Store Connect access" → re-auth with `xcrun altool`
- Build number not incremented → bump `CURRENT_PROJECT_VERSION` in project.pbxproj and retry
- Missing entitlements → ensure `.entitlements` file is in the Copy Bundle Resources phase
- Provisioning profile issues → `security find-identity -v -p codesigning` to list valid identities

**Team ID:** U9782HGY2C

### React Native project (pkmn-btl-sim)

**Uses xcodebuild via the Xcode workspace, NOT EAS Build (EAS costs money).**

Scheme: `PBSim`, workspace at `ios/PBSim.xcworkspace`. ExportOptions.plist is in `errs/` from previous builds — copy to project root if needed.

```bash
cd ios

# 1. Install pods if needed
pod install

# 2. Bundle JS (Expo/React Native handles this in build phase, but verify)

# 3. Clean
xcodebuild clean -workspace PBSim.xcworkspace -scheme PBSim -configuration Release

# 4. Archive
xcodebuild archive \
  -workspace PBSim.xcworkspace \
  -scheme PBSim \
  -configuration Release \
  -archivePath ./build/PBSim.xcarchive \
  -destination 'generic/platform=iOS' \
  CODE_SIGN_IDENTITY="Apple Distribution" \
  CODE_SIGN_STYLE=Manual

# 5. Export IPA
xcodebuild -exportArchive \
  -archivePath ./build/PBSim.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath ./build/export

# 6. Upload to App Store Connect
xcrun altool --upload-app \
  -f ./build/export/PBSim.ipa \
  -t ios \
  -u <APPLE_ID> \
  -p <APP_SPECIFIC_PASSWORD>
```

Additional pkmn-btl-sim failures:
- CocoaPods out of sync → `pod install` or `pod install --repo-update`
- Hermes build issues → `npx expo prebuild --clean` then `pod install` then retry
- Bundle ID: com.tanmay.pbs
- ASC App ID: 6760085983

## Git

- Never force push to main
- Always run tests before committing
- Commit messages: lowercase, imperative mood, concise

## Code Style

- No unnecessary comments or docstrings
- No over-engineering — simplest solution that works
- Don't add features that weren't requested
