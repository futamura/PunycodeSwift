# Security Policy

## Supported versions

Only the latest released version receives security updates.

| Version | Supported |
| ------- | --------- |
| 3.x     | ✅        |
| < 3.0   | ❌        |

## Reporting a vulnerability

Please report vulnerabilities privately via [GitHub private vulnerability reporting](https://github.com/futamura/PunycodeSwift/security/advisories/new). Do **not** open a public issue for security problems.

Include:

- A description of the issue and its impact
- Steps to reproduce (input strings that trigger the problem are especially helpful)
- The library version and platform

You can expect an initial response within a week. Fixes are released as a new patch version; version tags are immutable, so a fix always means a new release.

## Scope

PunycodeSwift is a pure Swift string-processing library with no dependencies, no network access, and no file I/O. The most relevant vulnerability classes are incorrect encoding/decoding results (e.g. IDNA spoofing vectors) and crashes or unbounded resource use on malicious input.
