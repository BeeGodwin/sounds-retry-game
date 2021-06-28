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
    
    func createSceneContents() {
        backgroundColor = SKColor.gray
        scaleMode = SKSceneScaleMode.aspectFit
        
        createSprite()
    }
    
    func createSprite() {
        if let lightGreyTexture = container?.textureManager.debugLightGrey() {
            let sprite = SKSpriteNode(texture: lightGreyTexture)
            sprite.position = CGPoint(x: 0, y: 0)
            self.addChild(sprite)
        }
        
        if let darkGreyTexture = container?.textureManager.debugDarkGrey() {
            let spriteTwo = SKSpriteNode(texture: darkGreyTexture)
            spriteTwo.position = CGPoint(x: 64, y: 0)
            self.addChild(spriteTwo)
        }
    }
}

