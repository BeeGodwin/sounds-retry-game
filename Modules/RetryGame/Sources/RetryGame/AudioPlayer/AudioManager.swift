import AVFoundation

class AudioManager: ObserverProtocol {
    
    var audioPlayer: AVAudioPlayer?
    
    init(eventBus: EventBusProtocol) {
        eventBus.subscribe(to: .control, with: self)
    }
    
    func receiveEvent(_ event: EventProtocol) {
        let path = Bundle.main.path(forResource: "boing1", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
        } catch {
            // nada
        }
    }
}
