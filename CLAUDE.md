# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

PunycodeSwift — a pure Swift library (no dependencies) that encodes/decodes Punycode (RFC 3492) and IDNA hostnames via `String` / `Substring` extensions. Runs on all Apple platforms and Linux. Distributed via SPM. Carthage compatibility is best-effort (not CI-verified); CocoaPods distribution has ended (3.0.0 is the last version published under the pod name `Punycode`).

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
bundle exec fastlane gen_docs         # DocC static site into docc-site/ (via scripts/gen_docs.sh)
bundle exec fastlane set_version      # prompt for version; sets MARKETING_VERSION in the pbxproj
bundle exec fastlane bump_version     # patch/minor/major bump; same effect

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

- Single source of truth for the version: `MARKETING_VERSION` in `Punycode.xcodeproj/project.pbxproj`. Fastlane and CI both read it. Never edit versions by hand — use `fastlane set_version` / `bump_version`.
- Branch flow: work on `develop`, PR into `main`.
- CI (`.github/workflows/main.yml`) runs on push and pull request to `main`/`develop`: lint → per-platform xcodebuild tests (simulator devices resolved at runtime via `simctl`) → SPM (macOS + Linux via the official Swift container). It does not release. Carthage builds are not CI-verified.
- The only required branch-protection check is `CI Success`. Codecov statuses are informational: `codecov.yml` gives the project status a 1% threshold, but the patch status targets the auto baseline and may fail on PRs whose new lines are defensive/unreachable guards — that does not block merging.
- Simulator test jobs occasionally abort with exit code 134 during teardown after every test passed; rerun the failed jobs (`gh run rerun <id> --failed`) instead of debugging the code.
- Documentation (`.github/workflows/docs.yml`) builds the DocC site with `scripts/gen_docs.sh` (symbolgraph-extract with `-emit-extension-block-symbols` — required because the whole public API is extensions on String/Substring — then `docc convert`) and deploys it to GitHub Pages on every push to `main`. The site is not tracked in git; `docs/` no longer exists.
- Releasing is a separate, explicit step: push a bare version tag (e.g. `4.0.1`) matching `MARKETING_VERSION`. `.github/workflows/release.yml` then verifies the tag against the project version and creates a GitHub Release (notes taken from the tag's `CHANGELOG.md` section, falling back to generated notes). Use `./run.sh` → "Github - Update tag" to create the tag.
- Version tags are immutable: both the release workflow and `run.sh` fail if the tag already exists. To re-release, bump the version — never delete/re-push a tag.
- Keep `CHANGELOG.md` (Keep a Changelog format) current: user-facing changes go under **Unreleased**; when releasing, rename that section to the new version with the date and add its compare link. The release workflow extracts this section for the GitHub Release notes.
