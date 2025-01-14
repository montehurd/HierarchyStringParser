import XCTest
//import Foundation

@testable import HierarchyStringParser

class HierarchyStringParserTests: XCTestCase {

    var smallHierarchyString: String = ""
    var parsedResultsArray: Array<HierarchyElement> = [HierarchyElement]()
        
    override func setUp() {
        super.setUp()

        let smallHierarchyString = """
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
        
        XCTAssertNotNil(smallHierarchyString)
        
        parsedResultsArray = parseHierarchyString(smallHierarchyString)

        // print("------------------------")
        // print(parsedResultsArray)
        // print("------------------------")
        // for thisElement in parsedResultsArray {
        //     print(thisElement)
        // }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetChildrenOfRoot() {
        let childrenOfRoot = parsedResultsArray.childrenOfIndex(-1)
        XCTAssertEqual(childrenOfRoot.map{$0.index}, [0,5,8,16,31,53])
        XCTAssertEqual(childrenOfRoot.map{$0.caption}, ["breakfast","cats","vegetables","foods","states","colors"])
    }
    
    func testGetChildrenOfBreakfast() {
        let childrenOfBreakfast = parsedResultsArray.childrenOfIndex(0)
        XCTAssertEqual(childrenOfBreakfast.map{$0.index}, [1,2])
        XCTAssertEqual(childrenOfBreakfast.map{$0.caption}, ["cheese","eggs"])
    }
    
    func testGetChildrenOfMinnesota() {
        let childrenOfMinnesota = parsedResultsArray.childrenOfIndex(40);
        XCTAssertEqual(childrenOfMinnesota.map{$0.index}, [41,50])
        XCTAssertEqual(childrenOfMinnesota.map{$0.caption}, ["activities","counties"])
    }
    
    func testGetAncestryOfRiver() {
        let ancestryOfRiver = parsedResultsArray.ancestryOfIndex(48);
        XCTAssertEqual(ancestryOfRiver.map{$0.index}, [48,44,41,40,31])
        XCTAssertEqual(ancestryOfRiver.map{$0.caption}, ["river","fishing","activities","minnesota","states"])
    }
    
    func testGetAncestryOfCherries() {
        let ancestryOfCherries = parsedResultsArray.ancestryOfIndex(56);
        XCTAssertEqual(ancestryOfCherries.map{$0.index}, [56,54,53])
        XCTAssertEqual(ancestryOfCherries.map{$0.caption}, ["cherries","red","colors"])
    }
    
    func testGetAncestryOfCherriesExclusive() {
        let ancestryOfCherries = parsedResultsArray.ancestryOfIndex(56, inclusive: false);
        XCTAssertEqual(ancestryOfCherries.map{$0.index}, [54,53])
        XCTAssertEqual(ancestryOfCherries.map{$0.caption}, ["red","colors"])
    }

    func testGetSiblingsOfWheat() {
        let siblingsOfWheat = parsedResultsArray.siblingsOfIndex(19);
        XCTAssertEqual(siblingsOfWheat.map{$0.index}, [18,19,20,21,22])
        XCTAssertEqual(siblingsOfWheat.map{$0.caption}, ["french","wheat","white","rye","oat"])
    }

    func testGetSiblingsOfWheatExclusive() {
        let siblingsOfWheat = parsedResultsArray.siblingsOfIndex(19, inclusive: false);
        XCTAssertEqual(siblingsOfWheat.map{$0.index}, [18,20,21,22])
        XCTAssertEqual(siblingsOfWheat.map{$0.caption}, ["french","white","rye","oat"])
    }

	func testIsDescendent() {
	    XCTAssertTrue(parsedResultsArray.isIndex(49, descendantOfIndex: 44))
	    XCTAssertFalse(parsedResultsArray.isIndex(49, descendantOfIndex: 34))
	    XCTAssertFalse(parsedResultsArray.isIndex(30, descendantOfIndex: 29))
	    XCTAssertFalse(parsedResultsArray.isIndex(53, descendantOfIndex: 31))
	}
     
	func testLargeStringParsingPerformance() {
	    let largeHierarchyString = String(repeating: smallHierarchyString, count: 1000)
	    self.measure {
	        _ = parseHierarchyString(largeHierarchyString)
	    }
	}

	func testLargeStringGetChildrenPerformance() {
	    let largeHierarchyString = String(repeating: smallHierarchyString, count: 1000)
	    let results: [HierarchyElement] = parseHierarchyString(largeHierarchyString)
	    self.measure {
	        _ = results.childrenOfIndex(1000)
	    }
	}

    static var allTests : [(String, (HierarchyStringParserTests) -> () throws -> Void)] {
        return [
            ("testGetChildrenOfRoot", testGetChildrenOfRoot),
            ("testGetChildrenOfBreakfast", testGetChildrenOfBreakfast),
            ("testGetChildrenOfMinnesota", testGetChildrenOfMinnesota),
            ("testGetAncestryOfRiver", testGetAncestryOfRiver),
            ("testGetAncestryOfCherries", testGetAncestryOfCherries),
            ("testGetSiblingsOfWheat", testGetSiblingsOfWheat),
            ("testIsDescendent", testIsDescendent),
            ("testLargeStringParsingPerformance", testLargeStringParsingPerformance),
            ("testLargeStringGetChildrenPerformance", testLargeStringGetChildrenPerformance),
        ]
    }
}
