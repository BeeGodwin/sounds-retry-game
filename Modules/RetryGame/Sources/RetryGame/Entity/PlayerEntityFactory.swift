import SpriteKit

protocol PlayerEntityFactory {
    func build(on entity: Entity)
}

extension EntityFactory: PlayerEntityFactory {
    func build(on entity: Entity) {
        
        let walkTextures = container.textureManager.getPlayerWalk()
        
        if walkTextures.count == 0 { return }
        
        let tx = container.textureManager.getPlayerWalk()[0]
        
        let spriteComponent = SpriteComponent(texture: tx)
        let sprite = spriteComponent.sprite
        sprite.name = GameConstants.playerName
        
        let physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        physicsBody.allowsRotation = false
        physicsBody.contactTestBitMask = GameConstants.collisionBitMask

        sprite.physicsBody = physicsBody
        
        entity.addSpriteComponent(spriteComponent)
        
        entity.addPlayerControlComponent(PlayerControlComponent(eventBus: container.eventBus, physicsBody: physicsBody, spriteNode: sprite, textureManager: container.textureManager))
    }
}
