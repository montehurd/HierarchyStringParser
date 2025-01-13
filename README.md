A simple Swift package for parsing tabbed hierarchy strings.

# Requirements
- Swift 5.5 or later
- iOS 13.0+ / macOS 10.15+

# Installation

To add this package as a dependency to your project:

## Using Swift Package Manager (SPM):

Update your Package.swift file:
```
import PackageDescription

let package = Package(
    name: "YourAppOrLibrary",
    platforms: [
        .iOS(.v13), .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/montehurd/HierarchyStringParser.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourAppOrLibrary",
            dependencies: ["HierarchyStringParser"]
        )
    ]
)
```

## Alternatively, you can add the package directly in Xcode:
1. Open your project in Xcode.
2. Go to File > Add Packages.
3. Enter the repository URL: https://github.com/montehurd/HierarchyStringParser.git
4. Select the desired version (e.g., Up to Next Major Version starting with 1.0.0).

# Usage

Use HierarchyStringParser to parse tabbed hierarchy strings. Example:
```
import HierarchyStringParser

let input = """
breakfast
	cheese
	eggs
		white
		brown
cats
	tabby
	alley
vegetables
	carrots
		orange
	tomatoes
		roma
		heirloom
		green
			fried
foods
	bread
		french
		wheat
		white
		rye
		oat
	cheese
		cheddar
		swiss
		american
	vegetables
		cucumber
		tomato
		potato
states
	florida
		activities
			swimming
			running
			being weird
		counties
			hernando
			pinellas
	minnesota
		activities
			freezing
			being cold
			fishing
				lake
					walleye
					musky
				river
					bass
		counties
			aitkin
			carlton
colors
	red
		apples
		cherries
	green
	blue
	purple
"""
let result = parseHierarchyString(input)
print(result) // Outputs a structured hierarchy of elements
```

# Testing the Package

To test the package:
1. Run the tests from the command line:
   `swift test`
2. Open the package in Xcode for testing and debugging:
   `open Package.swift`

# Continuous Integration (CI)

This project includes a GitHub Actions workflow to automatically test the package on every push or pull request. To see the workflow file, check .github/workflows/swift.yml.

# License

MIT License