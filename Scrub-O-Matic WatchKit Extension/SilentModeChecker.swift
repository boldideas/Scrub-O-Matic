//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//


import AVFoundation

struct SilentModeChecker {
    
    private init() {}
    
    static var isDeviceInSilentMode: Bool {
        let audioSession = AVAudioSession.sharedInstance()
        let currentRoute = audioSession.currentRoute
        let hasHeadphones = currentRoute.outputs.contains { $0.portType == .headphones }
        let isSilentSwitchOn = (audioSession.outputVolume == 0.0 && !hasHeadphones)

        return isSilentSwitchOn
    }
}
