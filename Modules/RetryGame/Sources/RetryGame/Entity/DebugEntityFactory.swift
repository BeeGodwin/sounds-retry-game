import SpriteKit

protocol DebugEntityFactory {
    func build(on entity: Entity, with flavour: DebugEntityFlavour)
}

enum DebugEntityFlavour {
    case dark
    case light
}

// MARK: bin it

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
        var texture: SKTexture?
        if let tx = texture {
            entity.addSpriteComponent(SpriteComponent(texture: tx))
        }
    }
}
