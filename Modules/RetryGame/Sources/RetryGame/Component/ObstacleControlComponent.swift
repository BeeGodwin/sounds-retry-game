import GameplayKit

class ObstacleControlComponent: GKComponent {
    
    var sprite: SKSpriteNode
    let physicsBody: SKPhysicsBody?
    let animator: AnimatorComponent
    let textureManager: TextureManager
    
    init(sprite: SKSpriteNode, animator: AnimatorComponent, textureManager: TextureManager) {
        self.sprite = sprite
        self.physicsBody = sprite.physicsBody
        self.animator = animator
        self.textureManager = textureManager
        super.init()
        setActive(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setActive(_ isActive: Bool) {
        let random = GKRandomDistribution(forDieWithSideCount: GameConstants.obstacleSprites.count)
        let obstacleSprite = GameConstants.obstacleSprites[random.nextInt() - 1]
        
        sprite.isHidden = !isActive
        
        if isActive {
            sprite.physicsBody = physicsBody
            animator.updateAnimation(with: textureManager.getAnimationFrames(for: obstacleSprite))
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
