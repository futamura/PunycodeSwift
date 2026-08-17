# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

PunycodeSwift — a pure Swift library (no dependencies) that encodes/decodes Punycode (RFC 3492) and IDNA hostnames via `String` / `Substring` extensions. Distributed primarily via SPM. Carthage compatibility is best-effort (not CI-verified); CocoaPods distribution (pod name: `Punycode`) ends when the trunk becomes read-only on 2026-12-02.

## Commands

```bash
# Build and test (SPM)
swift build
swift test

# Run a single test method
swift test --filter PunycodeTests/<testMethodName>

# Lint (enforced in CI via swift-format, not SwiftLint)
swift-format lint --ignore-unparsable-files --configuration .swift-format --recursive Sources Tests

# Fastlane lanes (require `bundle install` first; Ruby/Python managed by mise)
bundle exec fastlane tests            # xcodebuild tests on all platforms (macOS/iOS/tvOS/watchOS/visionOS) + slather coverage
bundle exec fastlane lint_swift       # swift-format lint
bundle exec fastlane build_spm        # swift build + test
bundle exec fastlane build_carthage   # Carthage builds per platform
bundle exec fastlane lint_cocoapods   # pod lib lint
bundle exec fastlane gen_docs         # jazzy docs into docs/
bundle exec fastlane set_version      # prompt for version; syncs pbxproj + podspec + .jazzy.yml
bundle exec fastlane bump_version     # patch/minor/major bump; same sync

# Interactive job menu (fzf)
./run.sh
```

Xcode-based test for a specific platform (what CI runs):

```bash
xcodebuild -project Punycode.xcodeproj -scheme Punycode -destination "platform=macOS" clean test
```

## Architecture

Three source files in `Sources/`:

- `Punycode.swift` — `Puny` class, the entire RFC 3492 implementation (`encodePunycode` / `decodePunycode`) plus IDNA hostname handling (`encodeIDNA` / `decodedIDNA`, which split on `.` and apply the `xn--` ACE prefix per label).
- `Extensions.swift` — the public API surface: computed vars `punycodeEncoded`, `punycodeDecoded`, `idnaEncoded`, `idnaDecoded` on `Substring` (primary) and `String` (forwards to `Substring`). All return `String?`, nil on invalid input.
- `Helpers.swift` — internal utilities (`Substring.lastIndex(of:)`, `UnicodeScalar.isValid`).

Tests live in `Tests/PunycodeTests.swift` (single XCTest file; SPM test target name is `PunycodeSwiftTests`).

## Versioning and release

- Single source of truth for the version: `MARKETING_VERSION` in `Punycode.xcodeproj/project.pbxproj`. Fastlane and CI both read it. Never edit versions by hand — use `fastlane set_version` / `bump_version`, which also sync `Punycode.podspec` and `.jazzy.yml`.
- Branch flow: work on `develop`, PR into `main`.
- CI (`.github/workflows/main.yml`) runs on push and pull request to `main`/`develop`: lint → per-platform xcodebuild tests (simulator devices resolved at runtime via `simctl`) → SPM → pod lib lint. It does not release. Carthage builds are not CI-verified.
- After 2026-12-02 (CocoaPods trunk read-only): remove the `lint_cocoapods` job from `main.yml` and the pod push from `release.yml`.
- Releasing is a separate, explicit step: push a bare version tag (e.g. `3.0.1`) matching `MARKETING_VERSION`. `.github/workflows/release.yml` then verifies the tag against the project version, creates a GitHub Release (notes taken from the tag's `CHANGELOG.md` section, falling back to generated notes), and pushes to CocoaPods trunk. Use `./run.sh` → "Github - Update tag" to create the tag.
- Version tags are immutable: both the release workflow and `run.sh` fail if the tag or trunk version already exists. To re-release, bump the version — never delete/re-push a tag.
- Keep `CHANGELOG.md` (Keep a Changelog format) current: user-facing changes go under **Unreleased**; when releasing, rename that section to the new version with the date and add its compare link. The release workflow extracts this section for the GitHub Release notes.
