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
            self.addChild(factory.build(.light)!)
            self.addChild(factory.build(.dark)!)
        }
//        if let lightGreyTexture = container?.textureManager.debugLightGrey() {
//            let sprite = SKSpriteNode(texture: lightGreyTexture)
//            sprite.position = CGPoint(x: 0, y: 0)
//            self.addChild(sprite)
//        }
//
//        if let darkGreyTexture = container?.textureManager.debugDarkGrey() {
//            let spriteTwo = SKSpriteNode(texture: darkGreyTexture)
//            spriteTwo.position = CGPoint(x: 64, y: 0)
//            self.addChild(spriteTwo)
//        }
    }
}

