import SpriteKit

protocol ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour)
}

enum ParallaxRowEntityFlavour {
    case cycling([EntityPrototype], CGPoint, CGFloat, CGFloat?)
}

extension EntityFactory: ParallaxRowEntityFactory {
    func build(on entity: Entity, with flavour: ParallaxRowEntityFlavour) {
        switch flavour {
        case .cycling(let prototypes, let position, let distance, let width): // could compose those params into a type
            addCyclingParallaxRowComponent(to: entity, with: prototypes, at: position, distance, width)
        }
    }
    
    private func addCyclingParallaxRowComponent(to entity: Entity, with prototypes: [EntityPrototype], at position: CGPoint, _ distance: CGFloat, _ width: CGFloat?) {
        guard let sceneWidth = width else { return }
        
        entity.skNode.position = position // TODO: doesn't belong here, belongs in the component system
        
        let cellSize = 64 * distance
        let numCells = Int((sceneWidth + cellSize * 2) / cellSize)
        let rowWidth = Int(CGFloat(numCells) * cellSize)
        
        for idx in 0...numCells {
            let cell = create(entity: prototypes[idx % prototypes.count])
            entity.node.addChild(cell.node)
            cell.skNode.setScale(distance)
            cell.skNode.position.x = CGFloat(-rowWidth / 2) + cellSize * CGFloat(idx)
        }
        // ok, now make the component and the component system to get back to moving parallax.
    }
}
