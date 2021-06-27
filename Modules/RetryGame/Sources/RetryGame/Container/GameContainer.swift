import UIKit
import SpriteKit

public class GameContainer {
    
    var hostView: UIView
    var retryDelegate: RetryDelegateProtocol
    
    public init(on view: UIView, with delegate: RetryDelegateProtocol) {
        hostView = view
        retryDelegate = delegate
        
        bootstrap()
    }
    
    private func bootstrap() {

        let eventBus = EventBus()
        
        let game = Game(eventBus: eventBus)
        
        let rect = hostView.bounds
        let gameView = GameView(frame: rect)
        gameView.inputManager = InputManager(eventBus: eventBus)
        hostView.addSubview(gameView)
        
        let scene = GameScene(size: rect.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gameView.presentScene(scene)
    }
}
