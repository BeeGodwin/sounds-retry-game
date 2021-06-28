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
        print("building debug light")
        return SKNode()
    }
    
    private func buildDark() -> SKNode {
        print("building debug dark")
        return SKNode()
    }
}
