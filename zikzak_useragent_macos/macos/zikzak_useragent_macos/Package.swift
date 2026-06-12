// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "zikzak_useragent_macos",
    platforms: [
        .macOS("10.14")
    ],
    products: [
        .library(
            name: "zikzak_useragent_macos",
            type: .static,
            targets: ["zikzak_useragent_macos"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "zikzak_useragent_macos"
        )
    ]
)
