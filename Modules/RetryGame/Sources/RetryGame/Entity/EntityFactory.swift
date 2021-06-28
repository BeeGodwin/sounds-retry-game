import GameplayKit

protocol EntityFactoryProtocol {
    
    var container: GameContainerProtocol { get }
    
    func create(producing kind: EntityFactoryProducing) -> SKNode?
}

enum EntityFactoryProducing {
    case debug(DebugEntityFlavour)
}

class EntityFactory: EntityFactoryProtocol {
    
    let container: GameContainerProtocol
    
    init(container: GameContainerProtocol) {
        self.container = container
    }
    
    func create(producing kind: EntityFactoryProducing) -> SKNode? {
        var result: SKNode?
        switch kind {
        case .debug(let flavour):
            result = self.build(flavour)
        }
        return result
    }
}
