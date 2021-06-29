import GameplayKit

protocol EntityFactoryProtocol {
    
    var container: GameContainerProtocol { get }
    
    func create(entity kind: EntityFactoryProducing) -> Entity
}

enum EntityFactoryProducing {
    case debug(DebugEntityFlavour)
}

class EntityFactory: EntityFactoryProtocol {
    
    let container: GameContainerProtocol
    
    init(container: GameContainerProtocol) {
        self.container = container
    }
    
    func create(entity kind: EntityFactoryProducing) -> Entity {
        let entity = Entity()
        switch kind {
        case .debug(let flavour):
            build(on: entity, with: flavour)
        }
        return entity
    }
        
    // needs to have references to any GKComponentSystem object managing components
}
