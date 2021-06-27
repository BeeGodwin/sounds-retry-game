import UIKit
import SpriteKit

public class GameContainer {
    
    var hostView: UIView
    var retryDelegate: RetryDelegateProtocol
    
    public init(on view: UIView, with delegate: RetryDelegateProtocol) {
        hostView = view
        retryDelegate = delegate
        
        setUpGame()
    }
    
    private func setUpGame() {

        let rect = hostView.bounds
        let gameView = GameView(frame: rect)
        
        let inputManager = InputManager()
        let game = Game()
        inputManager.attach(game)
        
        gameView.inputManager = inputManager
        
        hostView.addSubview(gameView)
        
        let scene = GameScene(size: rect.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gameView.presentScene(scene)
        
    }
}
