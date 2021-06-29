import SpriteKit

class Game: ObserverProtocol {
    
    let container: GameContainerProtocol
    let scene: GameScene
    var row: ParallaxRow?
    
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
        
        spawnParallax()
    }
    
    func spawnParallax() {
        if let factory = container.parallaxFactory {
            row = factory.createRow(in: scene, from: [.debug(.dark), .debug(.light)], at: CGPoint(x: 0, y: 0), distance: 1.0)
        }
    }

    func update() {
        if let spawnedRow = row {
            spawnedRow.moveBy(distance: 1)
        }
    }
}
