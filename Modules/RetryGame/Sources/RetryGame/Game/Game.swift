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
        guard let factory = container.factory, let sceneWidth = scene.view?.bounds.width else { return }
        
        parallax = ParallaxRowSystem(maxSpeed: 256.0)
                
        let rows: [EntityPrototype] = [
            .parallaxRow(.cycling([.debug(.dark), .debug(.light)], ParallaxRowParameters(distance: 0.25, width: sceneWidth, y: 48))),
            .parallaxRow(.cycling([.debug(.light), .debug(.dark)], ParallaxRowParameters(distance: 0.5, width: sceneWidth, y: 32))),
            .parallaxRow(.cycling([.debug(.dark), .debug(.light)], ParallaxRowParameters(distance: 1, width: sceneWidth, y: 0))),
            .parallaxRow(.cycling([.debug(.light), .debug(.dark)], ParallaxRowParameters(distance: 2, width: sceneWidth, y: -64))),
        ]
        
        parallax?.spawn(rows: rows, on: scene, from: factory)
    }

    func update(_ delta: TimeInterval) {
        if !running { return }
        parallax?.update(delta)
    }
}
