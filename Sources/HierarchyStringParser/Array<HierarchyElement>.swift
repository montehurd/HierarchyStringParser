//  Created by Monte Hurd on 8/30/16.
//  Copyright © 2016 Monte Hurd. All rights reserved.

import Foundation

extension Array where Element: HierarchyElement {

    public func childrenOfIndex(_ index: Int) -> [HierarchyElement] {
        // When seeking root level "children" we have to check every item since we
        // have no depth differences we can use to safely bail out early.
        if index == -1 {
            return self.filter { $0.parentIndex == index }
        }else{
            // If not seeking root level items we can compare depths so we can stop
            // checking for children asap.
            var output:Array = []
            for i in stride(from: index, to: self.count-1, by: 1){
                if (self[i].parentIndex == index) {
                    output.append(self[i])
                    if self[i].depth <= self[index].depth {
                        break
                    }
                }
            }
            return output;
        }
    }
    
    public func siblingsOfIndex(_ index: Int) -> [HierarchyElement] {
        if (index < 0){
            return []
        }
        return self.childrenOfIndex(self[index].parentIndex);
    }
    
    public func ancestryOfIndex(_ index: Int) -> [HierarchyElement] {
        var thisIndex = index;
        var output:Array = []
        repeat {
            output.append(self[thisIndex])
            thisIndex = self[thisIndex].parentIndex
        } while (thisIndex != -1);
        return output;
    }
    
    public func isIndex(_ indexOne: Int, descendantOfIndex indexTwo: Int) -> Bool {
        let ancestors = self.ancestryOfIndex(indexOne);
        for thisElement in ancestors {
            if(thisElement.index == indexTwo){
                return true;
            }
        }
        return false;
    }
}
