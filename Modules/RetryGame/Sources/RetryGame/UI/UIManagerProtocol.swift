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
        
        let score = SKLabelNode(text: scoreLabelText)
        score.horizontalAlignmentMode = .right
        score.position = GameConstants.scoreLabelPosition
        scene.addChild(score)
        scoreLabel = score
        
        let prompt = SKLabelNode(text: GameConstants.startGamePromptText)
        prompt.horizontalAlignmentMode = .center
        prompt.position = GameConstants.promptLabelPosition
        scene.addChild(prompt)
        promptLabel = prompt
    }
    
    func receiveEvent(_ message: EventProtocol) {
        switch message.channel {
        case .game:
            guard let event = message.event as? GameEvent else { return }
            handleGameEvent(event)
        default:
            print("unhandled game event") // TODO: resolve this
        }
    }
    
    private func handleGameEvent(_ event: GameEvent) {
        switch event {
        case .gameStart:
            promptLabel.text = ""
        case .gameOver:
            promptLabel.text = GameConstants.gameOverPromptText
        }
    }
}
