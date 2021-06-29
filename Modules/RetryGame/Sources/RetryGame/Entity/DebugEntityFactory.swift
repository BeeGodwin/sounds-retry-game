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
            addSpriteComponent(to: entity, flavour: .light)
        case .dark:
            addSpriteComponent(to: entity, flavour: .dark)
        }
    }
    
    private func addSpriteComponent(to entity: Entity, flavour: DebugEntityFlavour) {
        let textures = container.textureManager
        var texture: SKTexture?
        switch flavour {
        case .light:
            texture = textures.debugLightGrey()
        case .dark:
            texture = textures.debugDarkGrey()
        }
        if let tx = texture {
            entity.addComponent(SpriteComponent(on: entity.node, texture: tx))
        }
    }
}
