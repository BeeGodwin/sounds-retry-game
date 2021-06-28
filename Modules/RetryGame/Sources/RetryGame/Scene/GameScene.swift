import SpriteKit

class GameScene: SKScene {
    
    var contentCreated = false
    
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
        let texture = SKTexture(image: UIImage(named: "lightgrey", in: .module, compatibleWith: nil)!)
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: 0, y: 0)
        self.addChild(sprite)
        let textureTwo = SKTexture(image: UIImage(named: "darkgrey", in: .module, compatibleWith: nil)!)
        let spriteTwo = SKSpriteNode(texture: textureTwo)
        spriteTwo.position = CGPoint(x: 64, y: 0)
        self.addChild(spriteTwo)
    }
}

