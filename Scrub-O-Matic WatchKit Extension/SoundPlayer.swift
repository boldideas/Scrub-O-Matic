//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//


import AVFoundation

struct SoundPlayer {
    
    private init() {}
    
    static func play(_ soundName: String, withExtension soundFileExtension: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundFileExtension) else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            let sound = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            sound.play()
        } catch let error {
            print("There was an error playing the sound: \(error.localizedDescription)")
        }
    }
}
