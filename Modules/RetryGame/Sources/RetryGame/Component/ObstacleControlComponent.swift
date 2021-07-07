import GameplayKit

class ObstacleControlComponent: GKComponent {
    var sprite: SKSpriteNode
    let physicsBody: SKPhysicsBody?
    
    init(sprite: SKSpriteNode) {
        self.sprite = sprite
        self.physicsBody = sprite.physicsBody
        super.init()
        setActive(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setActive(_ isActive: Bool) {
       
        sprite.isHidden = !isActive
        
        if isActive {
            sprite.physicsBody = physicsBody
        } else {
            sprite.physicsBody = nil
        }
    }
}

extension Entity {
    func addObstacleControlComponent(_ component: ObstacleControlComponent) {
        self.addComponent(component)
    }
}
