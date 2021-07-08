import AVFoundation

class SoundManager: ObserverProtocol {
    
    var audioPlayer: AVAudioPlayer?
    
    var soundPlayers = [String: [AVAudioPlayer]]()
    
    init(eventBus: EventBusProtocol, soundDefinitions: [String: (String, String)]) {
        eventBus.subscribe(to: .control, with: self)
        let loader = AudioLoader()
        soundPlayers = loader.load(from: soundDefinitions)
    }
    
    func receiveEvent(_ event: EventProtocol) {
        // noop for now
    }
}
