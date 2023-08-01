//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//


import Foundation

struct BrushingInterval {
    
    static var time: TimeInterval {
        #if DEBUG
        4
        #else
        120
        #endif
    }
}
