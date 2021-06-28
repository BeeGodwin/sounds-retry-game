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
        if let factory = container.factory as? DebugEntityFactory {
            if let lightEntity = factory.build(.light) {
                lightEntity.position = CGPoint(x: x, y: 0)
                scene.addChild(lightEntity)
            }
            if let darkEntity = factory.build(.dark) {
                darkEntity.position = CGPoint(x: x + 64, y: 0)
                scene.addChild(darkEntity)
            }
        }
    }
    
    func update() {
        let move = SKAction.move(by: CGVector(dx: -1, dy: 0), duration: 0.1)
        scene.children.forEach { node in
            if node.position.x <= -256 {
                node.removeAllActions()
                node.position.x = 256
            }
            node.run(move)
        }
    }
}
