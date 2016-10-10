import XCTest
//import Foundation

@testable import HierarchyStringParser

class HierarchyStringParserTests: XCTestCase {

    var smallHierarchyString: String = ""
    var parsedResultsArray: Array<HierarchyElement> = [HierarchyElement]()
        
    override func setUp() {
        super.setUp()
        
        let smallHierarchyString = ""
        + "breakfast"
            + "\n\tcheese"
            + "\n\teggs"
                + "\n\t\twhite"
                + "\n\t\tbrown"
        + "\ncats"
            + "\n\ttabby"
            + "\n\talley"
        + "\nvegetables"
            + "\n\tcarrots"
                + "\n\t\torange"
            + "\n\ttomatoes"
                + "\n\t\troma"
                + "\n\t\theirloom"
                + "\n\t\tgreen"
                    + "\n\t\t\tfried"
        + "\nfoods"
            + "\n\tbread"
                + "\n\t\tfrench"
                + "\n\t\twheat"
                + "\n\t\twhite"
                + "\n\t\trye"
                + "\n\t\toat"
            + "\n\tcheese"
                + "\n\t\tcheddar"
                + "\n\t\tswiss"
                + "\n\t\tamerican"
            + "\n\tvegetables"
                + "\n\t\tcucumber"
                + "\n\t\ttomato"
                + "\n\t\tpotato"
        + "\nstates"
            + "\n\tflorida"
                + "\n\t\tactivities"
                    + "\n\t\t\tswimming"
                    + "\n\t\t\trunning"
                    + "\n\t\t\tbeing weird"
                + "\n\t\tcounties"
                    + "\n\t\t\thernando"
                    + "\n\t\t\tpinellas"
            + "\n\tminnesota"
                + "\n\t\tactivities"
                    + "\n\t\t\tfreezing"
                    + "\n\t\t\tbeing cold"
                    + "\n\t\t\tfishing"
                        + "\n\t\t\t\tlake"
                            + "\n\t\t\t\t\twalleye"
                            + "\n\t\t\t\t\tmusky"
                        + "\n\t\t\t\triver"
                            + "\n\t\t\t\t\tbass"
                + "\n\t\tcounties"
                    + "\n\t\t\taitkin"
                    + "\n\t\t\tcarlton"
        + "\ncolors"
            + "\n\tred"
                + "\n\t\tapples"
                + "\n\t\tcherries"
            + "\n\tgreen"
            + "\n\tblue"
            + "\n\tpurple"
        
        XCTAssertNotNil(smallHierarchyString)
        
        parsedResultsArray = parseHierarchyString(smallHierarchyString)
        
        //print(parsedResultsArray)
        //for thisElement in parsedResultsArray {
        //    print(thisElement)
        //}
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
    
    func testGetSiblingsOfWheat() {
        let siblingsOfWheat = parsedResultsArray.siblingsOfIndex(19);
        XCTAssertEqual(siblingsOfWheat.map{$0.index}, [18,19,20,21,22])
        XCTAssertEqual(siblingsOfWheat.map{$0.caption}, ["french","wheat","white","rye","oat"])
    }
    
    func testIsDecendentOne() {
        XCTAssertTrue(parsedResultsArray.isIndex(49, descendantOfIndex: 44))
    }
    
    func testIsDecendentTwo() {
        XCTAssertFalse(parsedResultsArray.isIndex(49, descendantOfIndex: 34))
    }
    
    func testIsDecendentThree() {
        XCTAssertFalse(parsedResultsArray.isIndex(30, descendantOfIndex: 29))
    }
    
    func testIsDecendentFour() {
        XCTAssertFalse(parsedResultsArray.isIndex(53, descendantOfIndex: 31))
    }
    
    func testLargeStringParsingPerformance() {
        //TODO: figure out why this was 3x faster in Obj-C...
        let largeHierarchyString = Array(repeating: self.smallHierarchyString, count: 1000).joined(separator: "")
        self.measure {
            /*let results:Array<HierarchyElement>*/_ = parseHierarchyString(largeHierarchyString)
            /*
             for thisElement in results {
                print(thisElement)
             }
             */
        }
    }
    
    func testLargeStringGetChildrenPerformance() {
        let largeHierarchyString = Array(repeating: self.smallHierarchyString, count: 1000).joined(separator: "")
        let results:Array<HierarchyElement> = parseHierarchyString(largeHierarchyString)
        
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
            ("testIsDecendentOne", testIsDecendentOne),
            ("testIsDecendentTwo", testIsDecendentTwo),
            ("testIsDecendentThree", testIsDecendentThree),
            ("testIsDecendentFour", testIsDecendentFour),
            ("testLargeStringParsingPerformance", testLargeStringParsingPerformance),
            ("testLargeStringGetChildrenPerformance", testLargeStringGetChildrenPerformance),
        ]
    }
}
