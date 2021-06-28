import SpriteKit

class GameScene: SKScene {
    
    var contentCreated = false
    
    var container: GameContainer?
    
    override func didMove(to view: SKView) {
        if !contentCreated {
            createSceneContents()
           contentCreated = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // here's the game clock.
    }
    
    func createSceneContents() {
        backgroundColor = SKColor.gray
        scaleMode = SKSceneScaleMode.aspectFit
        
        createEntities()
    }
    
    func createEntities() {
        if let factory: DebugEntityFactory = container?.factory {
            if let lightEntity = factory.build(.light) {
                lightEntity.position = CGPoint(x: 0, y: 0)
                self.addChild(lightEntity)
            }
            if let darkEntity = factory.build(.dark) {
                darkEntity.position = CGPoint(x: 64, y: 0)
                self.addChild(darkEntity)
            }
        }
    }
}

