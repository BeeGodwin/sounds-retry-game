import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        if !(game?.gameState == GameState.running) { return }
        guard let aName = contact.bodyA.node?.name, let bName = contact.bodyB.node?.name else { return }
        
        if [aName, bName].firstIndex(of: GameConstants.floorName) != nil {
            game?.playerLanded()
            return
        }
        game?.playerCollidedWithObstacle()
    }
    
    func createSceneContents() {
        backgroundColor = SKColor.gray
        scaleMode = SKSceneScaleMode.aspectFit
        self.physicsWorld.contactDelegate = self
    }
}

