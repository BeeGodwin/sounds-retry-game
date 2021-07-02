import SpriteKit

class GameScene: SKScene {
    
    
    var game: Game?
    
    private var lastFrameTime: TimeInterval?
    private var contentCreated = false

    
    override func didMove(to view: SKView) {
        if !contentCreated {
            createSceneContents()
           contentCreated = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
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

