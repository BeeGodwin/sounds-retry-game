import GameplayKit
import SpriteKit

class Entity: GKEntity {
    let node: SKNode
    
    override init() {
        node = SKNode()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
