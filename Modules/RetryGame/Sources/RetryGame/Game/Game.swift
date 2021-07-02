import SpriteKit

class Game: ObserverProtocol {
    
    private let container: GameContainerProtocol
    private var parallax: ParallaxRowSystem?
    private var running = false
        
    init(container: GameContainerProtocol) {
        self.container = container
    }
    
    func start() {
        container.eventBus.subscribe(to: .input, with: self)
        spawnParallax()
    }
    
    func receiveEvent(_ message: EventProtocol) {
        running = !running // TODO: switch on the event type (even tho we should already be filtered b/c channels) and delegate to some private method
    }
    
    func update(_ delta: TimeInterval) {
        if !running { return }
        parallax?.update(delta)
    }
    
    private func spawnParallax() {
        guard let factory = container.factory, let scene = container.scene, let sceneWidth = scene.view?.bounds.width else { return }
        
        parallax = ParallaxRowSystem(maxSpeed: 256.0) // TODO: magic values here should instead be pulled out of some config object
                
        let rows: [EntityPrototype] = [
            .parallaxRow(.cycling([.debug(.dark), .debug(.light)], ParallaxRowParameters(distance: 0.25, width: sceneWidth, y: 48))),
            .parallaxRow(.cycling([.debug(.light), .debug(.dark)], ParallaxRowParameters(distance: 0.5, width: sceneWidth, y: 32))),
            .parallaxRow(.cycling([.debug(.dark), .debug(.light)], ParallaxRowParameters(distance: 1, width: sceneWidth, y: 0))),
            .parallaxRow(.cycling([.debug(.light), .debug(.dark)], ParallaxRowParameters(distance: 2, width: sceneWidth, y: -64))),
        ]
        
        parallax?.spawn(rows: rows, on: scene, from: factory)
    }
}
