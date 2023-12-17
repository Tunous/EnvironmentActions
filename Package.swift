// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "EnvironmentActions",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "EnvironmentActions",
            targets: ["EnvironmentActions"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "EnvironmentActions",
            dependencies: []
        ),
        .testTarget(
            name: "EnvironmentActionsTests",
            dependencies: ["EnvironmentActions"]
        ),
    ]
)
