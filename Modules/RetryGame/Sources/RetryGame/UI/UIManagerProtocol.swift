import SpriteKit

protocol UIManagerProtocol {
    func spawnUI(on scene: GameScene, eventBus: EventBusProtocol)
}

class UIManager: UIManagerProtocol, ObserverProtocol {
    
    private var score = 0
    private var promptLabel: SKLabelNode!
    private var scoreLabel: SKLabelNode!
    private var scoreLabelText: String {
        "Score: \(score)"
    }
    
    func spawnUI(on scene: GameScene, eventBus: EventBusProtocol) {
        
        eventBus.subscribe(to: .game, with: self)
        eventBus.subscribe(to: .score, with: self)
        
        let score = SKLabelNode(text: scoreLabelText)
        score.horizontalAlignmentMode = .right
        score.position = GameConstants.scoreLabelPosition
        score.zPosition = 1
        scene.addChild(score)
        scoreLabel = score
        
        let prompt = SKLabelNode(text: GameConstants.startGamePromptText)
        prompt.horizontalAlignmentMode = .center
        prompt.position = GameConstants.promptLabelPosition
        prompt.zPosition = 1
        scene.addChild(prompt)
        promptLabel = prompt
    }
    
    func receiveEvent(_ message: EventProtocol) {
        switch message.channel {
        case .game:
            guard let event = message.event as? GameEvent else { return }
            handleGameEvent(event)
        case .score:
            guard let event = message.event as? ScoreEvent else { return }
            handleScoreEvent(event)
        default:
            print("unhandled event")
        }
    }
    
    private func handleGameEvent(_ event: GameEvent) {
        switch event {
        case .gameStart:
            promptLabel.text = ""
        case .gameOver:
            promptLabel.text = GameConstants.gameOverPromptText
        case .gameReady:
            promptLabel.text = GameConstants.startGamePromptText
        }
    }
    
    private func handleScoreEvent(_ event: ScoreEvent) {
        switch event {
        case .incrementBy(let increment):
            score += increment
        case .reset:
            score = 0
        }
        scoreLabel.text = scoreLabelText
    }
}
