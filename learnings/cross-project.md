# Cross-Project Learnings

Patterns, solutions, and knowledge discovered in one project that apply to others.

---

## TestFlight Deployment (all iOS projects)
- Team ID: U9782HGY2C
- Always increment build number before archiving
- SwiftUI apps: manual xcodebuild + ExportOptions.plist + altool upload
- React Native: EAS Build + EAS Submit
- Success rate historically ~20% — see global-constraints.md for exact steps

## SwiftUI Architecture (goDealApp, AbsolutelyNot)
- Both use MVVM with GameEngine pattern
- Both use MultipeerConnectivity + GameKit for multiplayer
- Both have ExportOptions.plist for App Store Connect
- Patterns from one directly transfer to the other

## Local Multiplayer (goDealApp, AbsolutelyNot)
- MultipeerConnectivity requires Bonjour service registration in Info.plist
- Auto-reconnect with grace period improves stability (goDealApp solved this)
- Could apply same pattern to AbsolutelyNot if not already done
