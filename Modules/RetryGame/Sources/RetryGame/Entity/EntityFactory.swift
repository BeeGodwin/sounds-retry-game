import GameplayKit

protocol EntityFactoryProtocol {
    
    var container: GameContainer { get }
    
    func create(producing kind: EntityFactoryProducing) -> SKNode?
}

enum EntityFactoryProducing {
    case debug(DebugEntityFlavour)
}

class EntityFactory: EntityFactoryProtocol {
    
    let container: GameContainer
    
    init(container: GameContainer) {
        self.container = container
    }
    
    func create(producing kind: EntityFactoryProducing) -> SKNode? {
        var result: SKNode?
        switch kind {
        case .debug(let flavour):
            guard let factory = self as? DebugEntityFactory else { return nil }
            result = factory.build(flavour)
        }
        return result
    }
}
