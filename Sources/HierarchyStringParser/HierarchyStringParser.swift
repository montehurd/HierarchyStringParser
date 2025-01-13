//  Created by Monte Hurd on 9/12/16.
//  Copyright © 2016 Monte Hurd. All rights reserved.

import Foundation

//returns an array of HierarchyElements. string must use tab indentation to denote parentage. one entry per line. no blank lines.
public func parseHierarchyString(_ string: String) -> Array<HierarchyElement> {

    var depth = 0, lastDepth = 0, birthOrder = 0, lastBirthOrder = 0, index = 0, parentIndex = 0, lastParentIndex = -1 //-1 denotes "root " element (the negative value is a reminder that an element has no parent)
    
    var output = [HierarchyElement]()
    string.enumerateLines {
        line, stop in
        
        depth = line.prefix(while: { $0 == "\t" }).count

//TODO: add assert here if blank line?

        //make sure the nesting is by increments of one
//TODO: add assert here ensuring if Depth is > than lastDepth that it is exactly 1 greater?
        depth = min(depth, lastDepth + 1)
        
        if (depth == lastDepth){
            //last item was a sibling, so use same parent index and increment birth order
            parentIndex = lastParentIndex
            birthOrder = lastBirthOrder + 1
        }else if (depth > lastDepth){
            //last item was parent, so use previous index as parent index and set birth order to 1
            parentIndex = index - 1
            birthOrder = 1
        }else if (depth < lastDepth){
            
            // tab depth decreased, so find last sibling and use same parent id and increment birth order
            // back up to the previous element (the -2 part) because no need to examine the last item as it's deeper and thus can't be the last sibling
            if depth < lastDepth {
                // Find the last sibling and use the same parent index, then increment birth order
                if let element = output.dropLast().last(where: { $0.depth == depth }) {
                    parentIndex = element.parentIndex
                    birthOrder = element.birthOrder + 1
                }
            }
        }
        
        let lineWithoutLeadingTabs = String(line.dropFirst(depth))

        let element = HierarchyElement(
            withIndex: index,
            parentIndex: parentIndex,
            depth: depth,
            birthOrder: birthOrder,
            caption: lineWithoutLeadingTabs
        )
        output.append(element)
        
        index += 1
        lastDepth = depth
        lastBirthOrder = birthOrder
        lastParentIndex = parentIndex
    }
    return output
}
