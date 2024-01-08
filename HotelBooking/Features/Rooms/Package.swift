// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rooms",
    platforms: [.iOS(.v16)],
    products: [.library(name: "Rooms",targets: ["Rooms"]),],
    dependencies: [
        .package(path: "Booking"),
        .package(path: "CoreModels"),
        .package(path: "Router"),
        .package(path: "UIComponents")
    ],
    targets: [
        .target(
            name: "Rooms",
            dependencies: [
                "Booking",
                "CoreModels",
                "Router",
                "UIComponents"
            ]
        ),
        .testTarget(
            name: "RoomsTests",
            dependencies: ["Rooms"]),
    ]
)

