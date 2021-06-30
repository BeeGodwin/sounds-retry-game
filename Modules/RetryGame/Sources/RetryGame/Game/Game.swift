import SpriteKit

class Game: ObserverProtocol {
    
    let container: GameContainerProtocol
    let scene: GameScene
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
        if let factory = container.factory {
            scene.addChild(factory.create(entity: .parallaxRow(.cycling([.debug(.dark), .debug(.light)], 1.0, scene.view?.bounds.width))).skNode)
        }
    }

    func update() {
        if !running { return }
        // TODO: needs refactor to be handled by a component system
    }
}
