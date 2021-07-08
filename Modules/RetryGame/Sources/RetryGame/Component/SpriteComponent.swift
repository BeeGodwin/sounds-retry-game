import GameplayKit

class SpriteComponent: GKComponent {
    
    let sprite: SKSpriteNode
    
    init(texture: SKTexture?) {
        
//        if let tx = texture {
        sprite = SKSpriteNode(texture: texture)
//        }
//        sprite = SKSpriteNode()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Entity {
    func addSpriteComponent(_ component: SpriteComponent) {
        self.sprite = component // TODO: is this needed? use a getter on entity? Or just use the getters in GK?
        self.addComponent(component)
        self.skNode.addChild(component.sprite)
    }
}
