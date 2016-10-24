import Foundation
import AVFoundation

class AudioController {
    private var audio = [String:AVAudioPlayer]()
    
    func preloadAudioEffects(effectFileNames:[String]) {
        for effect in AudioEffectFiles {
            let soundPath = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent(effect)
            let soundURL = NSURL.fileURLWithPath(soundPath)
            
            var loadError:NSError?
            let player = AVAudioPlayer(contentsOfURL: soundURL, error: &loadError)
            assert(loadError == nil, "Load sound failed")
            
            player.numberOfLoops = 0
            player.prepareToPlay()
            
            audio[effect] = player
        }
    }
    
    func playEffect(name:String) {
        if let player = audio[name] {
            if player.playing {
                player.currentTime = 0
            } else {
                player.play()
            }
        }
    }
    
}



