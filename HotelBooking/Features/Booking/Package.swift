// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Booking",
    platforms: [.iOS(.v17)],
    products: [.library(name: "Booking",targets: ["Booking"]),],
    dependencies: [
        .package(path: "Models"),
        .package(path: "Router"),
        .package(path: "UIComponents"),
        .package(path: "MadePayment")
    ],
    targets: [
        .target(
            name: "Booking",
            dependencies: [
                "Models",
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

