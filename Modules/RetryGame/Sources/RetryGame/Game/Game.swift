import SpriteKit

class Game: ObserverProtocol {
    
    let container: GameContainerProtocol
    let scene: GameScene
    var rows = [ParallaxRow]()
    var running = false
    
    init(container: GameContainerProtocol, scene: GameScene) {
        self.container = container
        self.scene = scene
    }
    
    func start() {
        createEntities()
    }
    
    func receiveEvent(_ message: EventProtocol) {
        running = !running
    }
    
    func createEntities() {
        container.eventBus.subscribe(to: .input, with: self)
        
        spawnParallax()
    }
    
    func spawnParallax() {
        if let factory = container.parallaxFactory {
            rows.append(factory.createRow(in: scene, from: [.debug(.dark), .debug(.light)], at: CGPoint(x: 0, y: 48), distance: 0.25))
            rows.append(factory.createRow(in: scene, from: [.debug(.light), .debug(.dark)], at: CGPoint(x: 0, y: 32), distance: 0.5))
            rows.append(factory.createRow(in: scene, from: [.debug(.dark), .debug(.light)], at: CGPoint(x: 0, y: 0), distance: 1.0))
            rows.append(factory.createRow(in: scene, from: [.debug(.light), .debug(.dark)], at: CGPoint(x: 0, y: -64), distance: 2))
        }
    }

    func update() {
        if !running { return }
        for row in rows {
            row.moveBy(delta: 2)
        }
    }
}
