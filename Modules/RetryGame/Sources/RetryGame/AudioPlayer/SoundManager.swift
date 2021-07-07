import AVFoundation

class SoundManager: ObserverProtocol {
    
    var audioPlayer: AVAudioPlayer?
    
    var audioPlayers = [AVAudioPlayer]()
    
    init(eventBus: EventBusProtocol, audioPaths: [(String, String)]) {
        eventBus.subscribe(to: .control, with: self)
        let loader = AudioLoader()
        audioPlayers = loader.load(pathFragments: audioPaths)
    }
    
    func receiveEvent(_ event: EventProtocol) {
        // noop for now
    }
}
