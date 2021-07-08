import GameplayKit

class ParallaxRowComponent: GKComponent {
    
    let node: SKNode
    let distance: CGFloat
    let width: CGFloat
    let configurator: ParallaxEdgeConfiguring
    
    private var leftEdge: CGFloat { -width / 2 }
    private var wrapDistance: CGFloat { width + GameConstants.tileSize * distance }
    
    init(node: SKNode, distance: CGFloat, width: CGFloat, configurator: ParallaxEdgeConfiguring) {
        self.node = node
        self.distance = distance
        self.width = width
        self.configurator = configurator
        super.init()
        
        self.node.children.forEach { node in
            self.configurator.configure(node)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        moveBy(delta: CGFloat(seconds))
    }
    
    func moveBy(delta: CGFloat) {
        node.children.forEach { childNode in
            if isFloor(childNode) { return }
            childNode.position.x -= delta * distance
            if childNode.position.x <= leftEdge {
                childNode.position.x += wrapDistance
                configurator.configure(childNode)
            }
        }
    }
    
    private func isFloor(_ node: SKNode) -> Bool { // TODO: should this be in the parallax system at all? It shouldn't.
        if let _ = node.physicsBody { return true }
        return false
    }
}

extension Entity {
    func addParallaxRowComponent(_ component: ParallaxRowComponent) {
        self.addComponent(component)
    }
}
