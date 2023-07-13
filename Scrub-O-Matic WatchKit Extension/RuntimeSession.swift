//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//

import WatchKit

final class WatchKitSession {
    
    static let shared = WatchKitSession()

    private var session = WKExtendedRuntimeSession()

    func start() {
        session = WKExtendedRuntimeSession()
        session.start()
    }

    func stop() {
        session.invalidate()
    }
}
