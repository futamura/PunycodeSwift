// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Punycode",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "Punycode",
            targets: ["Punycode"])
    ],
    targets: [
        .target(
            name: "Punycode",
            path: "Sources"),
        .testTarget(
            name: "PunycodeSwiftTests",
            dependencies: ["Punycode"],
            path: "Tests"),
    ]
)
