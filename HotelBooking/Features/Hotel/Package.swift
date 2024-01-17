// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hotel",
    platforms: [.iOS(.v17)],
    products: [.library(name: "Hotel", targets: ["Hotel"]), ],
    dependencies: [
        .package(path: "Models"),
        .package(path: "Router"),
        .package(path: "Rooms"),
        .package(path: "UIComponents")
    ],
    targets: [
        .target(
            name: "Hotel",
            dependencies: [
                "Models",
                "Router",
                "Rooms",
                "UIComponents"
            ]
        ),
        .testTarget(name: "HotelTests",dependencies: ["Hotel"]),
    ]
)
