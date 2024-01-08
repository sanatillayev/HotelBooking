// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Router",
    platforms: [.iOS(.v16)],
    products: [
        .library( name: "Router", targets: ["Router"]),
    ],
    dependencies: [
        .package(path: "CoreModels")
    ],
    targets: [
        .target( name: "Router",
                 dependencies: [
                    "CoreModels"
                 ]
               ),
        .testTarget(name: "RouterTests",dependencies: ["Router"]),
    ]
)
