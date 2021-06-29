import SpriteKit

// this almost certainly wants to be refactored into ECS

protocol ParallaxRowFactoryProtocol {
    func createRow(in scene: GameScene, from prototype: [EntityFactoryProducing], at position: CGPoint, distance: CGFloat) -> ParallaxRow
}

class ParallaxRowFactory: ParallaxRowFactoryProtocol {
    
    let factory: EntityFactoryProtocol
 
    
    init(factory: EntityFactoryProtocol) {
        self.factory = factory
    }
    
    func createRow(in scene: GameScene, from prototype: [EntityFactoryProducing], at position: CGPoint, distance: CGFloat) -> ParallaxRow {
        guard let sceneWidth = scene.view?.bounds.width else { return ParallaxRow(node: SKNode(), cells: [], position: position, distance: distance, width: 0) }
        
        let node = SKNode()
        node.position = position
        scene.addChild(node)
        
        // only confirmed to work with powers of 2 right now!
        let cellSize = 64 * distance
        
        var cells = [Entity]()
        let numCells = Int((sceneWidth + cellSize * 2) / cellSize)
        let width = Int(CGFloat(numCells) * cellSize)
        for idx in 0...numCells {
            let cell = factory.create(entity: prototype[idx % prototype.count])
            cells.append(cell)
            node.addChild(cell.skNode)
            cell.skNode.setScale(distance)
            cell.skNode.position.x = CGFloat(-width / 2) + cellSize * CGFloat(idx)
        }
        
        return ParallaxRow(node: node, cells: cells, position: position, distance: distance, width: width)
    }
}
