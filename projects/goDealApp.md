# goDealApp

Go! Deal! — Monopoly Deal card game for iOS.

## Stack
SwiftUI, MultipeerConnectivity, GameKit/Game Center, native Swift (no dependencies)

## Current State (2026-03-17)
- Version 2.0, Build 21
- Mature — full game engine, AI, local + online multiplayer, customization
- 51 Swift files, 55 unit tests
- Comprehensive .claude/ docs (bugs.md, coding.md, testing.md)

## Recent Activity
- Auto-retry room join, deep linking, display names, emoji reactions
- Bug fix rounds: discard sheet, property display, action cards
- Rent card gradients, card colors per action type done

## Known Issues (from .claude/bugs.md, 2026-02-27)
- Group A: Hand UX & card interaction (banner overlap, double-tap discard)
- Group B: Animations (deck-to-hand draw, property payment)
- Group G: Customization (category images, crop/resize UI)

## TestFlight
- CLI via xcodebuild archive + export + altool upload
- Bundle ID: com.tanmaysharma.godeal
- Team ID: U9782HGY2C

## Next Steps
- Fix remaining bugs from Groups A, B, G
