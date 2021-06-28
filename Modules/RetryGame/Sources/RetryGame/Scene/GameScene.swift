import SpriteKit

class GameScene: SKScene {
    
    var contentCreated = false
    
    var container: GameContainerProtocol?
    var game: Game?
    
    override func didMove(to view: SKView) {
        if !contentCreated {
            createSceneContents()
           contentCreated = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let game = self.game {
            game.update()
        }
    }
    
    func createSceneContents() {
        backgroundColor = SKColor.gray
        scaleMode = SKSceneScaleMode.aspectFit
    }
}

