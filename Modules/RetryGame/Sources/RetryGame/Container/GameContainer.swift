import UIKit
import SpriteKit

protocol GameContainerProtocol {
    var factory: EntityFactoryProtocol? { get }
    var eventBus: EventBusProtocol { get }
    var textureManager: TextureManager { get }
}

public class GameContainer: GameContainerProtocol {
    
    var hostView: UIView
    var retryDelegate: RetryDelegateProtocol
    
    let textureManager: TextureManager
    let inputManager: InputManager
    let eventBus: EventBusProtocol
    
    var factory: EntityFactoryProtocol?
    
    public init(on view: UIView, with delegate: RetryDelegateProtocol) {
        hostView = view
        retryDelegate = delegate
        
        textureManager = TextureManager()
        eventBus = EventBus()
        inputManager = InputManager(eventBus: eventBus)
    }
    
    public func bootstrap() {
        
        factory = EntityFactory(container: self)
        
        let rect = hostView.bounds
        let gameView = GameView(frame: rect)
        gameView.inputManager = inputManager
        hostView.addSubview(gameView)
        
        let scene = GameScene(size: rect.size)
        scene.container = self
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let game = Game(container: self, scene: scene)
        
        gameView.presentScene(scene)
        scene.game = game
        game.start()
    }
}
