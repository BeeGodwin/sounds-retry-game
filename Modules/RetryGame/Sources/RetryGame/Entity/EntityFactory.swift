import GameplayKit

protocol EntityFactoryProtocol {
    
    var container: GameContainerProtocol { get }
    
    func create(entity kind: EntityFactoryProducing) -> SKNode?
}

enum EntityFactoryProducing {
    case debug(DebugEntityFlavour)
}

class EntityFactory: EntityFactoryProtocol {
    
    let container: GameContainerProtocol
    
    init(container: GameContainerProtocol) {
        self.container = container
    }
    
    func create(entity kind: EntityFactoryProducing) -> SKNode? { // this should no longer produce an SKNode but an Entity.
        var result: SKNode?
        switch kind {
        case .debug(let flavour):
            result = self.build(flavour)
        }
        return result
    }
    
    // should produce the vanilla entity here along with anything needed by entities generally
    
    // needs to have references to any GKComponentSystem object managing components
}
