// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "HierarchyTest",
    dependencies: [
       .package(url: "https://github.com/montehurd/HierarchyStringParser.git", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "HierarchyTest",
            dependencies: ["HierarchyStringParser"],
            path: "Sources"
        ),
    ]
)