import SpriteKit

struct ParallaxRow {
    
    let node: SKNode
    let cells: [Entity] // might be redundant?
    let position: CGPoint
    let distance: CGFloat
    let width: Int
    
    private var leftEdge: CGFloat { CGFloat(-width / 2) - 64 * distance }
    private var wrapDistance: CGFloat { CGFloat(width + 128 * Int(distance)) }
    
    // TODO: add movement behaviour here

    func moveBy(delta: CGFloat) {
        node.children.forEach { childNode in
            childNode.position.x -= delta * distance
            if childNode.position.x < leftEdge {
                childNode.position.x += wrapDistance
            }
        }
    }
}
