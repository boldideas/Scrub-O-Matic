//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//

import SwiftUI

struct BrushingFeedback {
    
    private init() {}
    
    static func sendStart() {
        WKInterfaceDevice.current().play(.start)
    }
    
    static func sendStop() {
        WKInterfaceDevice.current().play(.stop)
    }
    
    static func sendTimeElapsed() {
        WKInterfaceDevice.current().play(.success)
    }
    
    static func sendTimeElapsingForInterval(_ interval: TimeInterval, elapsingTime: Int) {
        
        let denominator = 4
        let quarter = interval.fractionedWith(numerator: 1, denominator: denominator).asInt()
        let half = interval.fractionedWith(numerator: 2, denominator: denominator).asInt()
        let threeQuarters = interval.fractionedWith(numerator: 3, denominator: denominator).asInt()

        let intervalsToSendFeedback = [quarter, half, threeQuarters]
        guard intervalsToSendFeedback.contains(elapsingTime) else {
            return
        }
        WKInterfaceDevice.current().play(.notification)
        
        /*
        let notifications: [Int: WKHapticType] = [quarter: .notification,
                                                  half: .directionDown,
                                                  threeQuarters: .directionUp]

        if let hapticNotification = notifications.first(where: {$0.key == elapsingTime})?.value {
            WKInterfaceDevice.current().play(hapticNotification)
        }
         */
    }
}
