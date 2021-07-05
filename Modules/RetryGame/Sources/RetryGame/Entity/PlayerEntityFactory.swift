import SpriteKit

protocol PlayerEntityFactory {
    func build(on entity: Entity)
}

extension EntityFactory: PlayerEntityFactory {
    func build(on entity: Entity) {
        let texture = container.textureManager.debugLightGrey()
        if let tx = texture {
            let spriteComponent = SpriteComponent(texture: tx)
            let sprite = spriteComponent.sprite
            let physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            physicsBody.allowsRotation = false
            sprite.physicsBody = physicsBody
            entity.addSpriteComponent(spriteComponent)
        }
        entity.addPlayerControlComponent(PlayerControlComponent(eventBus: container.eventBus))
    }
}