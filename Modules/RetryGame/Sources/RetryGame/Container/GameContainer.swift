import UIKit
import SpriteKit

public class GameContainer {
    
    var hostView: UIView
    var retryDelegate: RetryDelegateProtocol
    
    let textureManager: TextureManager
    let inputManager: InputManager
    let eventBus: EventBus
    
    public init(on view: UIView, with delegate: RetryDelegateProtocol) {
        hostView = view
        retryDelegate = delegate
        
        textureManager = TextureManager()
        eventBus = EventBus()
        inputManager = InputManager(eventBus: eventBus)
    }
    
    public func bootstrap() {
        
        let game = Game(eventBus: eventBus)

        let rect = hostView.bounds
        let gameView = GameView(frame: rect)
        gameView.inputManager = inputManager
        hostView.addSubview(gameView)
        
        let scene = GameScene(size: rect.size)
        scene.container = self
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gameView.presentScene(scene)
    }
}
