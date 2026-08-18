[![Swift Package Manager compatible](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)](https://github.com/futamura/PunycodeSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/futamura/PunycodeSwift)
[![Build](https://github.com/futamura/PunycodeSwift/actions/workflows/main.yml/badge.svg)](https://github.com/futamura/PunycodeSwift/actions/workflows/main.yml)
[![codecov](https://codecov.io/gh/futamura/PunycodeSwift/branch/main/graph/badge.svg)](https://codecov.io/gh/futamura/PunycodeSwift)
![Language](https://img.shields.io/badge/Language-Swift%205.9-orange.svg)
![License](https://img.shields.io/github/license/futamura/PunycodeSwift.svg)

# PunycodeSwift

<code>PunycodeSwift</code> is a pure Swift library to allows you to encode and decode `punycoded` strings by using String extension.

## What is Punycode?

Punycode is a representation of Unicode with the limited ASCII character subset used for Internet host names. Using Punycode, host names containing Unicode characters are transcoded to a subset of ASCII consisting of letters, digits, and hyphen, which is called the Letter-Digit-Hyphen (LDH) subset. For example, München (German name for Munich) is encoded as Mnchen-3ya. [(Wikipedia)](https://en.wikipedia.org/wiki/Punycode)

## Requirements
- macOS 10.13 or later
- iOS 12.0 or later
- tvOS 12.0 or later
- watchOS 4.0 or later
- visionOS 1.0 or later
- Linux
- Swift 5.9 or later (Xcode 15 or later) for Swift Package Manager

## Installation

Swift Package Manager is the recommended way to install PunycodeSwift.

> [!IMPORTANT]
> The CocoaPods trunk becomes permanently read-only on December 2, 2026. Versions released after that date will be available via Swift Package Manager (and Carthage on a best-effort basis) only. If you are using CocoaPods, please migrate to Swift Package Manager.

### Swift Package Manager

Add the following to your `Package.swift` file.

- macOS, iOS, tvOS, watchOS, visionOS, and Swift 5
    ```swift
    dependencies: [
        .package(url: "https://github.com/futamura/PunycodeSwift.git", .upToNextMajor(from: "3.0.0"))
    ]
    ```

- macOS, iOS, tvOS, and Swift 5
    ```swift
    dependencies: [
        .package(url: "https://github.com/futamura/PunycodeSwift.git", .upToNextMajor(from: "2.1.1"))
    ]
    ```

### Carthage

> [!NOTE]
> Carthage itself is in maintenance mode. Carthage compatibility is kept on a best-effort basis and is no longer verified by CI.

Add the following to your `Cartfile` and follow [these instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

- macOS, iOS, tvOS, watchOS, visionOS, and Swift 5

    ```
    github "futamura/PunycodeSwift" ~> 3.0
    ```

- macOS, iOS, tvOS, and Swift 5

    ```
    github "futamura/PunycodeSwift" ~> 2.0
    ```

- macOS, iOS, tvOS, and Swift 4

    ```
    github "futamura/PunycodeSwift" ~> 1.0
    ```

### CocoaPods

> [!WARNING]
> CocoaPods distribution ends when the trunk becomes read-only on December 2, 2026. Existing versions will remain installable, but no new versions will be published. Please migrate to Swift Package Manager.

To integrate PunycodeSwift into your project, add the following to your `Podfile`.

- macOS, iOS, tvOS, watchOS, visionOS, and Swift 5.0

    ```ruby
    pod 'Punycode', '~> 3.0'
    ```

- macOS, iOS, tvOS, and Swift 5.0

    ```ruby
    pod 'Punycode', '~> 2.0'
    ```

- macOS, iOS, tvOS, and Swift 4.2

    ```ruby
    pod 'Punycode', '~> 1.0'
    ```

## Usage

Full documentation is available at [https://futamura.github.io/PunycodeSwift/documentation/punycode/](https://futamura.github.io/PunycodeSwift/documentation/punycode/).

### Encode and decode IDNA:

```swift
import Punycode

var sushi: String = "寿司"

sushi = sushi.idnaEncoded!
print(sushi)  // xn--sprr0q

sushi = sushi.idnaDecoded!
print(sushi)  // "寿司"
```

### Encode and decode the host of a URL:

`idnaEncoded` expects a bare hostname. For a full URL, use `idnaEncodedURL` / `idnaDecodedURL`, which transform only the host and leave the scheme, userinfo, port, path, query, and fragment unchanged.

```swift
import Punycode

var url: String = "http://www.ラーメン.寿司.co.jp/メニュー"

url = url.idnaEncodedURL!
print(url)  // http://www.xn--4dkp5a8a.xn--sprr0q.co.jp/メニュー

url = url.idnaDecodedURL!
print(url)  // http://www.ラーメン.寿司.co.jp/メニュー
```

### Encode and decode Punycode directly:

`punycodeEncoded` / `punycodeDecoded` are the raw RFC 3492 transformation of a single label: no `xn--` prefix is added and dots are not treated as label separators.

```swift
import Punycode

var sushi: String = "寿司"

sushi = sushi.punycodeEncoded!
print(sushi)  // sprr0q

sushi = sushi.punycodeDecoded!
print(sushi)  // "寿司"
```

## Copyright

Punycode is released under MIT license, which means you can modify it, redistribute it or use it however you like.
