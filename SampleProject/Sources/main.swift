// hierarchytest.swift

import Foundation
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

let elements = parseHierarchyString(input)

print(elements.description)

print("\n=== Root Level Elements ===")
print(elements.childrenOfIndex(-1))

print("\n=== Children of 'foods' (index 16) ===")
print(elements.childrenOfIndex(16))

print("\n=== Siblings of 'wheat' bread (index 19) ===")
print(elements.siblingsOfIndex(19))

print("\n=== Ancestry of 'walleye' (index 46) ===")
print(elements.ancestryOfIndex(46))

print("\n=== Descendant Relationship Checks ===")
print("Is 'bass' (index 49) a descendant of 'fishing' (index 44)? \(elements.isIndex(49, descendantOfIndex: 44))")
print("Is 'fried' (index 15) a descendant of first 'vegetables' (index 8)? \(elements.isIndex(15, descendantOfIndex: 8))")