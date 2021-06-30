import SpriteKit

class Game: ObserverProtocol {
    
    let container: GameContainerProtocol
    let scene: GameScene
    var parallax = [Entity]()
    var running = false
    
    var parallaxSpeed = 64.0
    
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
        if let factory = container.factory {
            let layer = factory.create(entity: .parallaxRow(.cycling([.debug(.dark), .debug(.light)], 1.0, scene.view?.bounds.width)))
            parallax.append(layer)
            scene.addChild(layer.skNode)
        }
    }

    func update(_ delta: TimeInterval) {
        if !running { return }
        container.parallax?.update(deltaTime: delta * parallaxSpeed)
    }
}
