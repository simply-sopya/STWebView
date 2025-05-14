// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription



let package = Package(
    name: "STWebView",
    platforms: [
        .iOS(.v14) // ← Add this line if it's missing
    ],
    products: [
        .library(name: "STWebView", targets: ["STWebView"]),
    ],
    targets: [
        .target(name: "STWebView", path: "Sources/STWebView")
    ]
)
