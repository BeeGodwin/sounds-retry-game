import SpriteKit

protocol PlayerEntityFactory {
    func build(on entity: Entity)
}

extension EntityFactory: PlayerEntityFactory {
    func build(on entity: Entity) {
        let texture = container.textureManager.debugLightGrey()
        
        guard let tx = texture else { return }
        
        let spriteComponent = SpriteComponent(texture: tx)
        let sprite = spriteComponent.sprite
        sprite.name = GameConstants.playerName
        
        let physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height / 2)
        physicsBody.allowsRotation = false
        physicsBody.contactTestBitMask = GameConstants.collisionBitMask

        sprite.physicsBody = physicsBody
        
        entity.addSpriteComponent(spriteComponent)
        
        entity.addPlayerControlComponent(PlayerControlComponent(eventBus: container.eventBus, physicsBody: physicsBody))
    }
}
