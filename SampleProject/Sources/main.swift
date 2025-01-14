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