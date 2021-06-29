import SpriteKit

struct ParallaxRow {
    
    let node: SKNode
    let cells: [Entity] // might be redundant? might prefer to have an array of textures here?
    let position: CGPoint
    let distance: CGFloat
    let width: Int
    
    private var leftEdge: CGFloat { CGFloat(-width / 2) }
    private var wrapDistance: CGFloat { CGFloat(width + 64 * Int(distance)) }
    
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
