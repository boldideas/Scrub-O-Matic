//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//


import Foundation

struct BrushingInterval {
    
    static var time: TimeInterval {
        #if DEBUG
        10
        #else
        120
        #endif
    }
}
