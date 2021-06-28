import SpriteKit

protocol DebugEntityFactory {
    func build(_ flavour: DebugEntityFlavour) -> SKNode?
}

enum DebugEntityFlavour {
    case dark
    case light
}

extension EntityFactory: DebugEntityFactory {
    func light() -> SKNode? {
        return create(producing: .debug(.light))
    }
    
    func dark() -> SKNode? {
        return create(producing: .debug(.dark))
    }
    
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
        let node = SKNode()
        addSpriteNode(to: node, flavour: .light)
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
