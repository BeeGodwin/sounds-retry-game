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
        guard let width = scene.view?.bounds.width else { return ParallaxRow(node: SKNode(), cells: [], position: position, distance: distance) }
        
        let node = SKNode()
        node.position = position
        scene.addChild(node)
        
        var cells = [Entity]()
        let numCells = Int(width / 64 + 2)
        for idx in 0...numCells {
            let cell = factory.create(entity: prototype[idx % prototype.count])
            // TODO scale and position
            cells.append(cell)
            node.addChild(cell.skNode)
            cell.skNode.position.x = -(width / 2) + CGFloat(64 * idx)
        }
        
        return ParallaxRow(node: node, cells: cells, position: position, distance: distance)
    }
}
