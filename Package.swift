// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Example",
    products: [
        .executable(
            name: "Example",
            targets: ["Example"]),
    ],
    dependencies: [
        .package(path: "../CoreAVR"),
//        .package(url: "git@github.com/pdshelley/CoreAVR", from: "0.1"),
        .package(url: "https://github.com/microswift-packages/libc", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Example",
            dependencies: ["CoreAVR","libc"],
            path: ".",
            sources: ["main.swift"]),
    ]
)
