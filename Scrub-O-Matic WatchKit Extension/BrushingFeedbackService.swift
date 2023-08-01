//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//

import SwiftUI

final class BrushingFeedbackService: ObservableObject {
    
    private var timer: Timer?
    
    func sendStart() {
        WKInterfaceDevice.current().play(.start)
        startWatchKitSession()
    }
    
    func sendStop() {
        WKInterfaceDevice.current().play(.stop)
        timer?.invalidate()
        timer = nil
        stopWatchKitSession()
    }
}

extension BrushingFeedbackService {
    
    // MARK: Time Elapsed / Elapsing
    
    func sendTimeElapsed() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            WKInterfaceDevice.current().play(.success)
        }
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

extension BrushingFeedbackService {
    
    // MARK: WatchKitSession
    
    private func startWatchKitSession() {
        WatchKitSession.shared.start()
    }

    private func stopWatchKitSession() {
        WatchKitSession.shared.stop()
    }
}
