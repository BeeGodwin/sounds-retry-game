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
            addSpriteNode(to: entity.node, flavour: .light)
        case .dark:
            addSpriteNode(to: entity.node, flavour: .dark)
        }
    }
    
    private func addSpriteNode(to node: SKNode, flavour: DebugEntityFlavour) {
        let textures = container.textureManager
        var sprite: SKSpriteNode
        switch flavour {
        case .light:
            sprite = SKSpriteNode(texture: textures.debugLightGrey())
        case .dark:
            sprite = SKSpriteNode(texture: textures.debugDarkGrey())
        }
        node.addChild(sprite)
    }
}
