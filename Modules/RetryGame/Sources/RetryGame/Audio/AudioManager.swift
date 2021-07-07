import AVFoundation

class AudioManager: ObserverProtocol {
    
    let eventBus: EventBusProtocol
    
    var directory = [AudioClip: AVAudioPlayer]()
    
    init(eventBus: EventBusProtocol) {
        self.eventBus = eventBus
        eventBus.subscribe(to: .score, with: self)
        eventBus.subscribe(to: .game, with: self)
        eventBus.subscribe(to: .control, with: self)
        
        musicLoop()
    }
    
    func receiveEvent(_ event: EventProtocol) {
        print("playing a thing")
    }
    
    private func noop() {}
    
    private func musicLoop() {
        let urls = Bundle.module.urls(forResourcesWithExtension: "mp3", subdirectory: "Audio")
        
        guard let musicUrl = Bundle.module.url(forResource: "ukeloop", withExtension: "mp3") else {
            print("Music URL not found")
            return
        }
    }
}

enum AudioClip {
    case debug
}
