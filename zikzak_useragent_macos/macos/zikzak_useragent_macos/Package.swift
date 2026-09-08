// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "zikzak_useragent_macos",
    platforms: [
        .macOS("13.5")
    ],
    products: [
        .library(
            name: "zikzak-useragent-macos",
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
