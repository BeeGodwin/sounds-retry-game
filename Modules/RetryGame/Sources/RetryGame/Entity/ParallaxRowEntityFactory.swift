import SpriteKit

protocol ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour)
}

enum ParallaxRowEntityFlavour {
    case cycling([EntityPrototype], CGFloat, CGFloat?)
}

extension EntityFactory: ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour) {
        switch flavour {
        case .cycling(let prototypes, let distance, let width): // TODO: could compose those params into a type
            addCyclingParallaxRowComponent(to: entity, with: prototypes, at: distance, width)
        }
    }
    
    private func addCyclingParallaxRowComponent(to entity: Entity, with prototypes: [EntityPrototype], at distance: CGFloat, _ width: CGFloat?) {
        guard let sceneWidth = width else { return }
                
        let cellSize = 64 * distance // TODO: need to lose the consts here and go off the texture width instead? (Powers of 2 are good!)
        let numCells = Int((sceneWidth + cellSize * 2) / cellSize)
        let rowWidth = Int(CGFloat(numCells) * cellSize)
        
        for idx in 0...numCells {
            let cell = create(entity: prototypes[idx % prototypes.count])
            entity.node.addChild(cell.node)
            cell.skNode.setScale(distance)
            cell.skNode.position.x = CGFloat(-rowWidth / 2) + cellSize * CGFloat(idx)
        }
        
        entity.addParallaxRowComponent(ParallaxRowComponent(node: entity.skNode, distance: distance, width: Int(sceneWidth)))
    }
}
