import SpriteKit

protocol PlayerEntityFactory {
    func build(on entity: Entity)
}

extension EntityFactory: PlayerEntityFactory {
    func build(on entity: Entity) {
        
        let walkTextures = container.textureManager.getAnimationFrames(for: .playerWalk)
        if walkTextures.count == 0 { return }
        
        let tx = walkTextures[0]
        let spriteComponent = SpriteComponent(texture: tx)
        let sprite = spriteComponent.sprite
        sprite.name = GameConstants.playerName
        sprite.anchorPoint = CGPoint(x: 0.5, y: 0.25)
        
        let animatorComponent = AnimatorComponent(with: sprite)
        
        let physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        physicsBody.allowsRotation = false
        physicsBody.contactTestBitMask = GameConstants.collisionBitMask

        sprite.physicsBody = physicsBody
        
        entity.addSpriteComponent(spriteComponent)
        entity.addAnimatorComponent(animatorComponent)
        entity.addPlayerControlComponent(PlayerControlComponent(eventBus: container.eventBus, physicsBody: physicsBody, spriteNode: sprite, textureManager: container.textureManager, animator: animatorComponent))
    }
}
