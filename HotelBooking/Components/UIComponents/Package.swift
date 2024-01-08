// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription

let package = Package(
    name: "UIComponents",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "UIComponents",targets: ["UIComponents"]),
    ],
    dependencies: [],
    targets: [
        .target( name: "UIComponents"),
        .testTarget(name: "UIComponentsTests", dependencies: ["UIComponents"]),
    ]
)
