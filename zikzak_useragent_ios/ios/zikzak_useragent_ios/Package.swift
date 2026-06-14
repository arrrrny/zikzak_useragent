// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "zikzak_useragent_ios",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(
            name: "zikzak-useragent-ios",
            type: .static,
            targets: ["zikzak_useragent_ios"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "zikzak_useragent_ios"
        )
    ]
)
