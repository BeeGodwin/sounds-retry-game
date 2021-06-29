import GameplayKit

class SpriteComponent: GKComponent {
    
    let sprite: SKSpriteNode
    
    init(texture: SKTexture) {
        sprite = SKSpriteNode(texture: texture)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Entity {
    func addSpriteComponent(_ component: SpriteComponent) {
        self.sprite = component
        self.skNode.addChild(component.sprite)
    }
}
