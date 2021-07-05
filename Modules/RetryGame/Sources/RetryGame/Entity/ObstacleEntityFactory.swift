import SpriteKit

protocol ObstacleEntityFactory {
    func build(on entity: Entity, with flavour: ObstacleEntityFlavour)
}

enum ObstacleEntityFlavour {
    case debug
}

extension EntityFactory: ObstacleEntityFactory {
    func build(on entity: Entity, with flavour: ObstacleEntityFlavour) {
        switch flavour {
        case .debug:
            buildDebugObstacle(on: entity)
        }
    }
    
    private func buildDebugObstacle(on entity: Entity) {
        let textures = container.textureManager
        guard let texture = textures.debugDarkGrey() else { return }
        
        let spriteComponent = SpriteComponent(texture: texture)
        let sprite = spriteComponent.sprite
        sprite.name = GameConstants.obstacleName
        
        let physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height / 2)
        physicsBody.isDynamic = false

        sprite.physicsBody = physicsBody
        
        entity.addSpriteComponent(spriteComponent)
    }
}
