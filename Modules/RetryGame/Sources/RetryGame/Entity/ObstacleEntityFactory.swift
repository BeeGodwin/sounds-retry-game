import SpriteKit

protocol ObstacleEntityFactory {
    func build(on entity: Entity, with flavour: ObstacleEntityFlavour)
}


enum ObstacleEntityFlavour {
    case animated([SKTexture])
}

extension EntityFactory: ObstacleEntityFactory {
    func build(on entity: Entity, with flavour: ObstacleEntityFlavour) {
        switch flavour {
        case .animated(let textures):
            buildObstacle(on: entity, with: textures)
        }
    }
    
    private func buildObstacle(on entity: Entity, with textures: [SKTexture]) {

        if textures.count == 0 { return }
        
        let texture = textures[0] // TODO: OK now animate them with an animation component.
        
        let spriteComponent = SpriteComponent(texture: texture)
        let sprite = spriteComponent.sprite
        let physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height / 2)
        physicsBody.isDynamic = false
        sprite.physicsBody = physicsBody
        sprite.name = GameConstants.obstacleName
        
        let animatorComponent = AnimatorComponent(with: sprite)
        let obstacleControlComponent = ObstacleControlComponent(sprite: sprite, animator: animatorComponent, textureManager: container.textureManager)
        
        entity.addSpriteComponent(spriteComponent)
        entity.addAnimatorComponent(animatorComponent)
        entity.addObstacleControlComponent(obstacleControlComponent)
    }
}
