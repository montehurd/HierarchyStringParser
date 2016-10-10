//  Created by Monte Hurd on 9/11/16.
//  Copyright © 2016 Monte Hurd. All rights reserved.

import Foundation

public class HierarchyElement: CustomStringConvertible {
    
    //index of this HierarchyElement in the array of hierarchy elements returned by the HierarchyStringParser
    var index:Int
    
    //index of this element's parent
    var parentIndex:Int

    //generational depth of this element
    var depth:Int

    //describes when this element occurs in relation to its siblings
    var birthOrder:Int
    
    //the text from the hierarchy string
    var caption:String

    //pointer to other object for any additional data that needs to be associated with this element
    var userData:Any?

    public init(withIndex index:Int, parentIndex:Int, depth:Int, birthOrder:Int, caption:String) {
        self.index = index
        self.parentIndex = parentIndex
        self.depth = depth
        self.birthOrder = birthOrder
        self.caption = caption
        userData = nil
    }
    
    public var description:String {
        return "\n\(index)\t|\(String(repeating: "\t", count: depth))\"\(caption)\" depth=\(depth) parentIndex=\(parentIndex) birthOrder=\(birthOrder)"
    }
}
