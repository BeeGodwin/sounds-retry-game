import GameplayKit

protocol EntityFactoryProtocol {
    
    var container: GameContainerProtocol { get }
    
    func create(entity kind: EntityPrototype) -> Entity
}

enum EntityPrototype {
    case rowTile(RowTileEntityFlavour)
    case parallaxRow(ParallaxRowEntityFlavour)
    case player
    case obstacle(ObstacleEntityFlavour)
}

class EntityFactory: EntityFactoryProtocol {
    
    let container: GameContainerProtocol
    
    init(container: GameContainerProtocol) {
        self.container = container
    }
    
    func create(entity kind: EntityPrototype) -> Entity {
        let entity = Entity()
        switch kind {
        case .parallaxRow(let parallaxFlavour):
            build(on: entity, with: parallaxFlavour)
        case .player:
            build(on: entity)
        case .obstacle(let obstacleFlavour):
            build(on: entity, with: obstacleFlavour)
        case .rowTile(let rowTileFlavour):
            build(on: entity, with: rowTileFlavour)
        }
        return entity
    }
}
