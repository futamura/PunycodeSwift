# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Linux support, verified by CI (`swift build` / `swift test` on the official Swift container).
- GitHub Releases are now created automatically when a version tag is pushed.
- `CI Success` aggregate check for branch protection.
- Community files: `CHANGELOG.md`, `CONTRIBUTING.md`, `SECURITY.md`, issue and PR templates.

### Changed

- **Breaking**: `Package.swift` requires swift-tools 5.9 (Xcode 15 or later for SPM consumers) and declares explicit platforms: macOS 10.13, iOS 12, tvOS 12, watchOS 4, visionOS 1.
- Product bundle identifiers renamed from `com.gumob.*` to `dev.futamura.*`, completing the account rename.
- CI runs on pushes and pull requests to `main` and `develop`, on current macOS runner images, resolving simulator destinations at runtime.
- API documentation migrated from jazzy to DocC, built and deployed to GitHub Pages by CI; the generated site is no longer tracked in the repository. New URL: <https://futamura.github.io/PunycodeSwift/documentation/punycode/>.
- Releasing is now a separate tag-triggered workflow that verifies the tag against the project version before publishing. Version tags are immutable.
- Development tooling: Ruby 3.4 / Bundler 2.7, gems updated to clear all outstanding Dependabot alerts.

### Fixed

- `punycodeDecoded` returned garbage characters for malformed input instead of nil: inputs ending mid-digit-sequence (e.g. `"y-z"`) and inputs decoding to C1 control characters (e.g. `"abcd"`) now return nil ([#78](https://github.com/futamura/PunycodeSwift/issues/78)).
- `punycodeDecoded` / `punycodeEncoded` could crash on adversarial input due to unchecked integer overflow; the RFC 3492 overflow checks are now implemented and such inputs return nil ([#78](https://github.com/futamura/PunycodeSwift/issues/78)).
- `idnaDecoded` now accepts an uppercase `XN--` ACE prefix (RFC 5890 defines it as case-insensitive).

### Changed

- **Breaking**: `idnaEncoded` now maps the hostname before encoding — NFKC compatibility folding (full-width forms, alternate dots), lowercasing, and NFC — so inputs like `"ＧＯＯ．ＧＬ"` encode to `"goo.gl"` ([#4](https://github.com/futamura/PunycodeSwift/issues/4)). The full UTS #46 mapping table is intentionally not implemented. `punycodeEncoded` remains the raw RFC 3492 single-label transformation, now documented as such.

### Deprecated

- CocoaPods distribution ends when the trunk becomes read-only on 2026-12-02. Migrate to Swift Package Manager.
- Carthage support is best-effort and no longer CI-verified.

## [3.0.0] - 2024-08-28

### Added

- watchOS and visionOS support.
- Generated API documentation (jazzy), published via GitHub Pages.

### Changed

- Raised deployment targets: macOS 10.13, iOS 12.0, tvOS 12.0.
- Renamed the source directory from `Source` to `Sources`.

## [2.1.1] - 2024-08-22

### Changed

- Renamed the SPM test target for consistent naming.
- Project maintenance: CI and dependency updates.

## [2.1.0] - 2020-06-24

### Changed

- Tooling and CI maintenance (SwiftLint, gems, CocoaPods lint settings).

## [2.0.0] - 2019-08-09

### Added

- tvOS support (tvOS 11 and earlier included).

## [1.0.1] - 2019-02-08

### Fixed

- Packaging and CI fixes.

## [1.0.0] - 2018-11-19

### Added

- Initial release: Punycode (RFC 3492) encode/decode and IDNA encode/decode via `String` / `Substring` extensions.

[Unreleased]: https://github.com/futamura/PunycodeSwift/compare/3.0.0...HEAD
[3.0.0]: https://github.com/futamura/PunycodeSwift/compare/2.1.1...3.0.0
[2.1.1]: https://github.com/futamura/PunycodeSwift/compare/2.1.0...2.1.1
[2.1.0]: https://github.com/futamura/PunycodeSwift/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/futamura/PunycodeSwift/compare/1.0.1...2.0.0
[1.0.1]: https://github.com/futamura/PunycodeSwift/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/futamura/PunycodeSwift/releases/tag/1.0.0
