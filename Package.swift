// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyNavigator",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SwiftyNavigator", targets: ["SwiftyNavigator"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "SwiftyNavigator", path: "SwiftyNavigator"),
    ]
    
)
