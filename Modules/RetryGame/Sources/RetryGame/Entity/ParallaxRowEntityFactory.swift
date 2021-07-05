import SpriteKit

protocol ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour)
}

enum ParallaxRowEntityFlavour {
    case cycling([EntityPrototype], ParallaxRowParameters)
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
            entity.skNode.addChild(edgeNode)
        }
    }
}
