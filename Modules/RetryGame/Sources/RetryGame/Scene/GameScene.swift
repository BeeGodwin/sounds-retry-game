import SpriteKit

class GameScene: SKScene {
    
    var contentCreated = false
    
    var container: GameContainerProtocol?
    var game: Game?
    var lastFrameTime: TimeInterval?
    
    override func didMove(to view: SKView) {
        if !contentCreated {
            createSceneContents()
           contentCreated = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) { // TODO: doing this here is creating a circular reference?
        guard let game = self.game else { return }
        
        let lastFrame = lastFrameTime ?? currentTime
        
        let timeDelta = currentTime - lastFrame
        game.update(timeDelta)
        lastFrameTime = currentTime
    }
    
    func createSceneContents() {
        backgroundColor = SKColor.gray
        scaleMode = SKSceneScaleMode.aspectFit
    }
}

