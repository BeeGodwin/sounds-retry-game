import SpriteKit

protocol ParallaxEdgeConfiguring {
    func configureNode(_ node: SKNode)
}

class CyclingEdge: ParallaxEdgeConfiguring {

    let textures: [SKTexture]
    var index = 0
    
    init(with textures: [SKTexture]) {
        self.textures = textures
    }
    
    func configureNode(_ node: SKNode) {
        node.children.forEach { childNode in
            if let sprite = childNode as? SKSpriteNode {
                sprite.texture = textures[index]
                index = (index + 1) % textures.count
                return
            }
        }
    }
}

// TODO: add other configurators for other cases (obstacles, random)
