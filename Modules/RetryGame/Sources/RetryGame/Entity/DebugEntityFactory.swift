import SpriteKit

protocol DebugEntityFactory {
    func build(_ flavour: DebugEntityFlavour) -> SKNode?
}

enum DebugEntityFlavour {
    case dark
    case light
}

extension EntityFactory: DebugEntityFactory {
    
    func build(_ flavour: DebugEntityFlavour) -> SKNode? {
        var node: SKNode?
        switch flavour {
        case .light:
            node = buildLight()
        case .dark:
            node = buildDark()
        }
        return node
    }
    
    private func buildLight() -> SKNode {
        let node = SKNode() // let's hang an entity off of an SKNode
        addSpriteNode(to: node, flavour: .light) // let's make this a SpriteComponent that owns a sprite
        return node
    }
    
    private func buildDark() -> SKNode {
        let node = SKNode()
        addSpriteNode(to: node, flavour: .dark)
        return node
    }
    
    func addSpriteNode(to node: SKNode, flavour: DebugEntityFlavour) {
        let textureManager = container.textureManager
        var sprite: SKSpriteNode
        switch flavour {
        case .light:
            sprite = SKSpriteNode(texture: textureManager.debugLightGrey())
        case .dark:
            sprite = SKSpriteNode(texture: textureManager.debugDarkGrey())
        }
        node.addChild(sprite)
    }
}
