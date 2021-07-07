import AVFoundation

class AudioManager {
    
    var directory = [AudioClip: AVAudioPlayer]()
    
}


enum AudioClip {
    case debug
}
