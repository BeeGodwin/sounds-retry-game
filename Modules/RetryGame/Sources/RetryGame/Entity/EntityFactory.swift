import GameplayKit

protocol EntityFactoryProtocol {
    
    var container: GameContainerProtocol { get }
    
    func create(entity kind: EntityPrototype) -> Entity
}

enum EntityPrototype {
    case debug(DebugEntityFlavour)
    case parallaxRow(ParallaxRowEntityFlavour)
}

class EntityFactory: EntityFactoryProtocol {
    
    let container: GameContainerProtocol
    
    init(container: GameContainerProtocol) {
        self.container = container
    }
    
    func create(entity kind: EntityPrototype) -> Entity {
        let entity = Entity()
        switch kind {
        case .debug(let debugFlavour):
            build(on: entity, with: debugFlavour)
        case .parallaxRow(let parallaxFlavour):
            build(on: entity, with: parallaxFlavour)
        }
        return entity
    }
        
    // needs to have references to any GKComponentSystem object managing components
}
