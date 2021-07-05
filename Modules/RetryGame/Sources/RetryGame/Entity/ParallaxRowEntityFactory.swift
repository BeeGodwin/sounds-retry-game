import SpriteKit

protocol ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour)
}

enum ParallaxRowEntityFlavour {
    case cycling([EntityPrototype], ParallaxRowParameters)
    case obstacles
}

struct ParallaxRowParameters {
    var distance: CGFloat
    var width: CGFloat?
    var y: CGFloat
    var isGround: Bool = false
}

extension EntityFactory: ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour) {
        switch flavour {
        case .cycling(let prototypes, let parameters):
            addCyclingParallaxRowComponent(to: entity, with: prototypes, params: parameters)
        case .obstacles:
            addObstaclesParallaxRowComponent(to: entity)
        }
    }
    
    private func addCyclingParallaxRowComponent(to entity: Entity, with prototypes: [EntityPrototype], params: ParallaxRowParameters) { // TODO: this could/should take an array of textures? That would make prototype singular? or is that contextual based on what the layer's for?
        guard let sceneWidth = params.width else { return } // TODO: check if still needs to be optional. dont think it does
                
        let cellSize = GameConstants.tileSize * params.distance
        let numCells = Int((sceneWidth + cellSize * 2) / cellSize)
        let rowWidth = CGFloat(numCells) * cellSize
        
        let leftEdge = -(sceneWidth / 2)
        
        for idx in 0...numCells {
            let cell = create(entity: prototypes[idx % prototypes.count])
            entity.skNode.position.y = params.y
            entity.node.addChild(cell.node)
            cell.skNode.setScale(params.distance)
            cell.skNode.position.x = leftEdge + cellSize * CGFloat(idx)
        }
        let component = ParallaxRowComponent(node: entity.skNode, distance: params.distance, width: rowWidth)
        entity.addParallaxRowComponent(component)
        
        if params.isGround {
            let edgeNode = SKNode()
            let y = params.y + cellSize / 2
            let leftEnd = CGPoint(x: leftEdge, y: y)
            let rightEnd = CGPoint(x: -leftEdge, y: y)
            edgeNode.physicsBody = SKPhysicsBody(edgeFrom: leftEnd, to: rightEnd)
            edgeNode.name = GameConstants.floorName
            entity.skNode.addChild(edgeNode)
        }
    }
    
    private func addObstaclesParallaxRowComponent(to entity: Entity) {
        // TODO: proper obstacle spawning
        entity.skNode.position.y = 64
        let obstacle = create(entity: .obstacle(.debug))
        entity.node.addChild(obstacle.node)
        obstacle.skNode.position.x = 128
        
        let component = ParallaxRowComponent(node: entity.skNode, distance: 1, width: 1000)
        entity.addParallaxRowComponent(component)
    }
}
