// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "swift-clocks",
    platforms: [
        .macOS("27"),
        .iOS("27"),
        .tvOS("27"),
        .watchOS("27"),
        .visionOS("27")
    ],
    products: [
        .library(
            name: "Clocks",
            targets: ["Clocks"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-foundations/swift-kernel.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Clocks",
            dependencies: [
                .product(name: "Kernel Clock", package: "swift-kernel"),
            ]
        ),
        .testTarget(
            name: "Clocks Tests",
            dependencies: [
                "Clocks",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
