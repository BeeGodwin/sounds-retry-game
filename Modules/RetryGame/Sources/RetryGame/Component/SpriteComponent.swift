import GameplayKit

class SpriteComponent: Component {
    
    private let sprite: SKSpriteNode
    
    init(on node: SKNode, texture: SKTexture) {
        sprite = SKSpriteNode(texture: texture)
        node.addChild(sprite)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
