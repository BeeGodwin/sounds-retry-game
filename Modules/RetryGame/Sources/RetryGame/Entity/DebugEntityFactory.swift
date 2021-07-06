import SpriteKit

protocol DebugEntityFactory {
    func build(on entity: Entity, with flavour: DebugEntityFlavour)
}

enum DebugEntityFlavour {
    case dark
    case light
}

extension EntityFactory: DebugEntityFactory {
    
    func build(on entity: Entity, with flavour: DebugEntityFlavour) {
        switch flavour {
        case .light:
            addSpriteComponent(to: entity, flavour: .light) // TODO these no longer need flavours
        case .dark:
            addSpriteComponent(to: entity, flavour: .dark)
        }
    }
    
    private func addSpriteComponent(to entity: Entity, flavour: DebugEntityFlavour) {
        let textures = container.textureManager
        var texture: SKTexture?
        switch flavour {
        case .light:
            texture = textures.debugLightGrey() // TODO we don't need to assign textures here any more; leave that to the configurator
        case .dark:
            texture = textures.debugDarkGrey()
        }
        if let tx = texture {
            entity.addSpriteComponent(SpriteComponent(texture: tx))
        }
    }
}
