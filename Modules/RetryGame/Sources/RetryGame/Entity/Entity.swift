import GameplayKit
import SpriteKit

class Entity: GKEntity {
    
    let node: NodeComponent
    var sprite: SpriteComponent?
//    var parallax: ParallaxRowComponent? // TODO: don't like this being a profusion of nils, surely we could lose these. Putting in to try alternative component adding method
    
    var skNode: SKNode { node.skNode }
    
    override init() {
        node = NodeComponent()
        super.init()
        
        addNodeComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addNodeComponent() {
        self.addComponent(node)
    }
}
