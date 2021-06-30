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
}

extension EntityFactory: ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour) {
        switch flavour {
        case .cycling(let prototypes, let parameters):
            addCyclingParallaxRowComponent(to: entity, with: prototypes, params: parameters)
        }
    }
    
    private func addCyclingParallaxRowComponent(to entity: Entity, with prototypes: [EntityPrototype], params: ParallaxRowParameters) {
        guard let sceneWidth = params.width else { return }
                
        let cellSize = 64 * params.distance // TODO: need to lose the consts here and go off the texture width instead?
        let numCells = Int((sceneWidth + cellSize * 2) / cellSize)
        let rowWidth = Int(CGFloat(numCells) * cellSize)
        
        let leftEdge = -(sceneWidth / 2)
        
        for idx in 0...numCells {
            let cell = create(entity: prototypes[idx % prototypes.count])
            entity.skNode.position.y = params.y
            entity.node.addChild(cell.node)
            cell.skNode.setScale(params.distance)
            cell.skNode.position.x = leftEdge + cellSize * CGFloat(idx)
        }
        let component = ParallaxRowComponent(node: entity.skNode, distance: params.distance, width: Int(rowWidth))
        entity.addParallaxRowComponent(component)
    }
}
