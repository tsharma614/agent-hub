# pkmn-btl-sim

Pokemon Battle Simulator — cross-platform multiplayer Pokemon battle game.

## Stack
React Native 0.83, Expo 55, TypeScript, Socket.io, Vitest

## Current State (2026-03-17)
- Build 19 (iOS via EAS Build)
- Active development — most recent work: Elite Four + Champion easter egg mode
- Server deployed via Fly.io, GitHub Actions CI
- Multiple draft modes: standard, mega, monotype, Elite Four gauntlet

## Recent Activity
- Fixed E4 all-moves-miss bug (heal missing accuracy/evasion boosts)
- E4 move selection: stats, long-press details, team strip, PP heal bug fix
- Move selection phase for all drafts, movePool lookup fix, 20 new tests
- Elite Four + Champion easter egg: solo mega draft, move selection, 5-battle gauntlet

## Known Issues
- `errs/` directory with untracked error logs (investigate)

## TestFlight
- CLI via xcodebuild (workspace: ios/PBSim.xcworkspace, scheme: PBSim)
- NOT EAS Build (costs money) — uses same xcodebuild pipeline as SwiftUI projects
- ASC App ID: 6760085983
- Bundle ID: com.tanmay.pbs

## Next Steps
- TBD — pending ideation session
