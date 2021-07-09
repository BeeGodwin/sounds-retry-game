import GameplayKit

class AnimatorComponent: GKComponent {
    
    let sprite: SKSpriteNode
    
    init(with sprite: SKSpriteNode) {
        self.sprite = sprite
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAnimation(with frames: [SKTexture], interval: TimeInterval = GameConstants.defaultFrameInterval) {
        if frames.count == 0 { return }
        sprite.removeAllActions()
        if frames.count == 1 {
            sprite.texture = frames[0]
            return
        }
        sprite.run(SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: interval)))
    }
}


extension Entity {
    func addAnimatorComponent(_ component: AnimatorComponent){
        self.addComponent(component)
    }
}
