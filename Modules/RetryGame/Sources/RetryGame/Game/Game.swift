import SpriteKit

class Game: ObserverProtocol {
    
    let container: GameContainerProtocol
    let scene: GameScene
    var parallax: ParallaxRowSystem?
    var running = false
        
    init(container: GameContainerProtocol, scene: GameScene) {
        self.container = container
        self.scene = scene
    }
    
    func receiveEvent(_ message: EventProtocol) {
        running = !running
    }
    
    func start() {
        setUp()
    }
    
    func setUp() {
        container.eventBus.subscribe(to: .input, with: self)

        spawnParallax()
    }
    
    func spawnParallax() {
        parallax = ParallaxRowSystem(maxSpeed: 64.0)
        
        if let factory = container.factory {
            let layer = factory.create(entity: .parallaxRow(.cycling([.debug(.dark), .debug(.light)], 1.0, scene.view?.bounds.width)))
            parallax?.addRow(on: layer)
            scene.addChild(layer.skNode)
        }
    }

    func update(_ delta: TimeInterval) {
        if !running { return }
        parallax?.update(delta)
    }
}
