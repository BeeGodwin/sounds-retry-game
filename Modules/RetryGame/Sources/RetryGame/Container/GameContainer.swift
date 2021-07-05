import UIKit
import SpriteKit
import GameplayKit

protocol GameContainerProtocol {
    var factory: EntityFactoryProtocol? { get }
    var eventBus: EventBusProtocol { get }
    var textureManager: TextureManager { get }
    var scene: GameScene? { get }
    
    func bootstrap()
    func retryNetwork()
}

public class GameContainer: GameContainerProtocol {
    
    var factory: EntityFactoryProtocol?
    let eventBus: EventBusProtocol
    let textureManager: TextureManager
    var scene: GameScene?
    
    private var hostView: UIView
    private var retryDelegate: RetryDelegateProtocol
    
    public init(on view: UIView, with delegate: RetryDelegateProtocol) {
        hostView = view
        retryDelegate = delegate
        
        eventBus = EventBus()
        textureManager = TextureManager()
    }
    
    public func bootstrap() {
        
        factory = EntityFactory(container: self)
        
        let rect = hostView.bounds
        
        let gameView = GameView(frame: rect)
        enableDebug(gameView)
        gameView.inputManager = InputManager(eventBus: eventBus)
        hostView.addSubview(gameView)
        
        scene = GameScene(size: rect.size)
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let game = Game(container: self)
        scene?.game = game
        gameView.presentScene(scene)
        
        game.start()
    }
    
    func retryNetwork() {
        print("Calling retryDelegate")
    }
    
    private func enableDebug(_ gameView: GameView) {
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        gameView.showsDrawCount = true
    }
}
