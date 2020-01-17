// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "DirectLine",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "DirectLine",
            targets: ["DirectLine"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/gonzalezreal/SimpleNetworking", from: "1.0.0"),
    ],
    targets: [
        .target(name: "DirectLine", dependencies: ["SimpleNetworking"]),
        .testTarget(name: "DirectLineTests", dependencies: ["DirectLine"]),
    ]
)
