// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MadePayment",
    platforms: [.iOS(.v17)],
    products: [.library(name: "MadePayment",targets: ["MadePayment"]),],
    dependencies: [
        .package(path: "Router"),
        .package(path: "UIComponents")
    ],
    targets: [
        .target(
            name: "MadePayment",
            dependencies: [
                "Router",
                "UIComponents"
            ]
        ),
        .testTarget(
            name: "MadePaymentTests",
            dependencies: ["MadePayment"]),
    ]
)
