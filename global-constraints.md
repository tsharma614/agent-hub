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

Deployment is the most failure-prone part of the workflow. Follow these steps exactly.

### SwiftUI projects (goDealApp, AbsolutelyNot)

Each project has an `ExportOptions.plist` configured for App Store Connect.

```bash
# 1. Clean build folder
xcodebuild clean -scheme <SCHEME> -configuration Release

# 2. Archive
xcodebuild archive \
  -scheme <SCHEME> \
  -configuration Release \
  -archivePath ./build/<SCHEME>.xcarchive \
  -destination 'generic/platform=iOS' \
  CODE_SIGN_IDENTITY="Apple Distribution" \
  CODE_SIGN_STYLE=Manual

# 3. Export IPA
xcodebuild -exportArchive \
  -archivePath ./build/<SCHEME>.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath ./build/export

# 4. Upload to App Store Connect
xcrun altool --upload-app \
  -f ./build/export/<SCHEME>.ipa \
  -t ios \
  -u <APPLE_ID> \
  -p <APP_SPECIFIC_PASSWORD>
```

**Common failures:**
- Signing errors → check `CODE_SIGN_IDENTITY` matches provisioning profile
- "No accounts with App Store Connect access" → re-auth with `xcrun altool`
- Build number not incremented → bump `CURRENT_PROJECT_VERSION` in project.pbxproj before archiving
- Missing entitlements → ensure `.entitlements` file is in the Copy Bundle Resources phase

**Team ID:** U9782HGY2C

### React Native project (pkmn-btl-sim)

Uses EAS Build. Config is in `eas.json`.

```bash
# 1. Bump version in app.json (buildNumber field)
# 2. Build for iOS
npx eas build --platform ios --profile production

# 3. Submit to TestFlight
npx eas submit --platform ios --profile production
```

**Common failures:**
- Credentials expired → `npx eas credentials` to re-configure
- Build fails on native modules → `npx expo prebuild --clean` then retry
- ASC App ID: 6760085983

### Before ANY deployment

1. Run all tests first
2. Increment build number
3. Commit the version bump
4. Tag the commit: `git tag -a v<version>-b<build> -m "TestFlight build <build>"`

## Git

- Never force push to main
- Always run tests before committing
- Commit messages: lowercase, imperative mood, concise

## Code Style

- No unnecessary comments or docstrings
- No over-engineering — simplest solution that works
- Don't add features that weren't requested
