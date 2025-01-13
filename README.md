Simple Swift 3 package for parsing tabbed hierarchy strings

To add this parser as a dependency to a "Package.swift" manifest: 

```
import PackageDescription

let package = Package(
    name: "YourAppOrLibrary",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/montehurd/HierarchyStringParser.git", versions: Version(1,0,0)..<Version(2,0,0))
    ]
)
```
-----

After cloning, you can cd to "HierarchyStringParser", and run the following commands:
- "swift test" will run the tests from the terminal
- "swift package generate-xcodeproj" will generate an Xcode project (so you can run the parser's tests via Xcode

-----

Good Swift Package Manager tutorial: 
http://evgenii.com/blog/distributing-your-library-with-swift-package-manager/)

Simple commands for setting up a new package directory:
- mkdir SomePackage
- cd SomePackage
- swift package init --type library 

("library" can also be "executable" in the init command above)
