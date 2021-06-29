import SpriteKit

class Game: ObserverProtocol {
    
    let container: GameContainerProtocol
    let scene: GameScene
    
    init(container: GameContainerProtocol, scene: GameScene) {
        self.container = container
        self.scene = scene
    }
    
    func start() {
        createEntities()
    }
    
    func receiveEvent(_ message: EventProtocol) {
        print("\(message.channel) : \(message.event)")
    }
    
    func createEntities() {
        container.eventBus.subscribe(to: .input, with: self)
        
        for idx in 0...3 {
            spawnTilePair(at: idx * 128)
        }
    }
    
    func spawnTilePair(at x: Int) {
        if let factory = container.factory {
            let lightTile = factory.create(entity: .debug(.light))
            lightTile.node.position = CGPoint(x: x, y: 0)
            scene.addChild(lightTile.node)
            
            let darkTile = factory.create(entity: .debug(.dark))
            darkTile.node.position = CGPoint(x: x + 64, y: 0)
            scene.addChild(darkTile.node)
            
        }
    }
    
    func update() {
        let move = SKAction.move(by: CGVector(dx: -1, dy: 0), duration: 0.1)
        scene.children.forEach { node in // actions seem shonky, seeing some drift when actions are repeated over time. But then not doing this particularly stylishly anyway
            if node.position.x <= -256 {
                node.removeAllActions()
                node.position.x = 256
            }
            node.run(move)
        }
    }
}
