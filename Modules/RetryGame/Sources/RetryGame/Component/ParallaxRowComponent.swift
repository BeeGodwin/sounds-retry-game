import GameplayKit

class ParallaxRowComponent: GKComponent {
    
    let node: SKNode
//    let position: CGPoint // nah
    let distance: CGFloat
    let width: Int // TODO: int?
    
    private var leftEdge: CGFloat { CGFloat(-width / 2) }
    private var wrapDistance: CGFloat { CGFloat(width + 64 * Int(distance)) }
    
    init(node: SKNode, distance: CGFloat, width: Int) {
        self.node = node
//        self.position = position
        self.distance = distance
        self.width = width
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveBy(delta: CGFloat) {
        node.children.forEach { childNode in
            childNode.position.x -= delta * distance
            if childNode.position.x <= leftEdge {
                childNode.position.x += wrapDistance
                // TODO: pick a sprite on repositioning a cell
            }
        }
    }
}

extension Entity {
    func addParallaxRowComponent(_ component: ParallaxRowComponent) {
        self.addComponent(component)
    }
}
