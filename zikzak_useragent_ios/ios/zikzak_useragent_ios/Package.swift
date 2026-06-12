// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "zikzak_useragent_ios",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(
            name: "zikzak_useragent_ios",
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
