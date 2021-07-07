import SpriteKit

protocol ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour)
}

enum ParallaxRowEntityFlavour {
    case cycling([EntityPrototype], [SKTexture], ParallaxRowParameters)
    case obstacles(ParallaxRowParameters)
}

struct ParallaxRowParameters {
    var distance: CGFloat
    var width: CGFloat
    var y: CGFloat
    var isGround: Bool = false
}

private struct DerivedRowParameters {
    let cellSize: CGFloat
    let numCells: Int
    let rowWidth: CGFloat
    let leftEdge: CGFloat
}

extension EntityFactory: ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour) {
        switch flavour {
        case .cycling(let prototypes, let textures, let parameters):
            addCyclingParallaxRowComponent(to: entity, with: prototypes, textures, parameters)
        case .obstacles(let parameters):
            addObstaclesParallaxRowComponent(to: entity, with: parameters)
        }
    }
    
    private func deriveRowParameters(distance: CGFloat, width: CGFloat) -> DerivedRowParameters {
        let cellSize = GameConstants.tileSize * distance
        let numCells = Int((width + cellSize * 2) / cellSize)
        let rowWidth = CGFloat(numCells) * cellSize
        let leftEdge = -(width / 2)
        return DerivedRowParameters(cellSize: cellSize, numCells: numCells, rowWidth: rowWidth, leftEdge: leftEdge)
    }
    
    private func addCyclingParallaxRowComponent(to entity: Entity, with prototypes: [EntityPrototype], _ textures: [SKTexture], _ params: ParallaxRowParameters) {
    
        let computed = deriveRowParameters(distance: params.distance, width: params.width)
        
        for idx in 0...computed.numCells {
            let cell = create(entity: prototypes[idx % prototypes.count]) // TODO: give the node to the configurator
            entity.skNode.position.y = params.y
            entity.node.addChild(cell.node)
            cell.skNode.setScale(params.distance)
            cell.skNode.position.x = computed.leftEdge + computed.cellSize * CGFloat(idx)
        }
        
        let component = ParallaxRowComponent(node: entity.skNode, distance: params.distance, width: computed.rowWidth, configurator: CyclingEdge(with: textures))
        entity.addParallaxRowComponent(component)
        
        if params.isGround {
            let edgeNode = SKNode()
            let y = params.y + computed.cellSize / 2
            let leftEnd = CGPoint(x: computed.leftEdge, y: y)
            let rightEnd = CGPoint(x: -computed.leftEdge, y: y)
            edgeNode.physicsBody = SKPhysicsBody(edgeFrom: leftEnd, to: rightEnd)
            edgeNode.name = GameConstants.floorName
            entity.skNode.addChild(edgeNode)
        }
    }
    
    private func addObstaclesParallaxRowComponent(to entity: Entity, with params: ParallaxRowParameters) {
        let computed = deriveRowParameters(distance: params.distance, width: params.width)

        entity.skNode.position.y = params.y
        
        var obstacleEntities = [Entity]()
        
        for idx in 0...computed.numCells {
            let obstacle = create(entity: .obstacle(.debug))
            obstacle.skNode.position.x = computed.leftEdge + computed.cellSize * CGFloat(idx) //* 2)
            entity.node.addChild(obstacle.node)
            obstacleEntities.append(obstacle)
        }
                        
        let component = ParallaxRowComponent(node: entity.skNode, distance: 1, width: computed.rowWidth, configurator: ObstacleEdge(entities: obstacleEntities, eventBus: container.eventBus, generator: RandomisedFibonnaciProgressiveDifficultyGenerator()))
        entity.addParallaxRowComponent(component)
    }
}
