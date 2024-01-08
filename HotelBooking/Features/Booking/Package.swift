// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Booking",
    platforms: [.iOS(.v16)],
    products: [.library(name: "Booking",targets: ["Booking"]),],
    dependencies: [
        .package(path: "CoreModels"),
        .package(path: "Router"),
        .package(path: "UIComponents"),
        .package(path: "MadePayment")
    ],
    targets: [
        .target(
            name: "Booking",
            dependencies: [
                "CoreModels",
                "Router",
                "UIComponents",
                "MadePayment"
            ]
        ),
        .testTarget(
            name: "BookingTests",
            dependencies: ["Booking"]),
    ]
)

