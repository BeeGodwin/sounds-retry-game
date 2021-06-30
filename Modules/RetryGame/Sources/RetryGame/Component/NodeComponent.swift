import GameplayKit

class NodeComponent: GKComponent {

    let skNode: SKNode
    
    override init() {
        skNode = SKNode()
        super.init()
    }
    
    func addChild(_ nodeComponent: NodeComponent) {
        skNode.addChild(nodeComponent.skNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        // TODO: isn't getting added into the entity.
    }
}
