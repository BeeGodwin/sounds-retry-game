import SpriteKit

protocol PlayerEntityFactory {
    func build(on entity: Entity)
}

extension EntityFactory: PlayerEntityFactory {
    func build(on entity: Entity) {
        let texture = container.textureManager.debugLightGrey()
        if let tx = texture {
            entity.addSpriteComponent(SpriteComponent(texture : tx))
        }
        entity.addPlayerControlComponent(PlayerControlComponent(eventBus: container.eventBus))
    }
}
