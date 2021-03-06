import AVFoundation
import GameplayKit

class SoundManager: ObserverProtocol {

    var soundPlayers = [Sound: [AVAudioPlayer]]()
    
    init(eventBus: EventBusProtocol, soundDefinitions: [Sound: (String, String)]) {
        
        let loader = AudioLoader()
        soundPlayers = loader.load(from: soundDefinitions)
        
        eventBus.subscribe(to: .control, with: self)
        eventBus.subscribe(to: .score, with: self)
        eventBus.subscribe(to: .game, with: self)
    }
    
    func receiveEvent(_ message: EventProtocol) {
        switch message.channel {
        case .control:
            if let controlEvent = message.event as? ControlEvent {
                handleControlEvent(controlEvent)
            }
        case .game:
            if let gameEvent = message.event as? GameEvent {
                handleGameEvent(gameEvent)
            }
        case .score:
            if let scoreEvent = message.event as? ScoreEvent {
                handleScoreEvent(scoreEvent)
            }
        default:
            print("unhandled event")
        }
    }
    
    private func handleScoreEvent(_ event: ScoreEvent) {
        switch event {
        case .incrementBy:
            playAudio(.score)
        default:
            noop()
        }
    }
    
    private func handleControlEvent(_ event: ControlEvent) {
        switch event {
        case .jump:
            playAudio(.jump)
        default:
            noop()
        }
    }
    
    private func handleGameEvent(_ event: GameEvent) {
        switch event {
        case .gameOver:
            playAudio(.die)
        case .gameStart:
            playMusic()
        default:
            noop()
        }
    }
    
    private func playAudio(_ sound: Sound) {
        guard let players = soundPlayers[sound] else { return }
        if players.isEmpty { return }
        let random = GKRandomDistribution(forDieWithSideCount: players.count)
        let chosenPlayer = players[random.nextInt() - 1]
        setVolume(chosenPlayer)
        chosenPlayer.play()
    }
    
    private func playMusic() {
        guard let player = soundPlayers[.music]?.first else { return }
        setVolume(player)
        player.numberOfLoops = -1
        player.play()
    }
    
    private func setVolume(_ player: AVAudioPlayer) {
        if #available(iOS 10.0, *) {
            player.setVolume(GameConstants.audioVolume, fadeDuration: 0.0)
        }
    }
    
    private func noop () {}
}
