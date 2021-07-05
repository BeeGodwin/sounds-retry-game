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
        container.eventBus.subscribe(to: .game, with: self)
        spawnParallax()
    }
    
    func receiveEvent(_ message: EventProtocol) {
        switch message.channel {
        case .input:
            handleInputEvent()
        case .game:
            if let gameEvent = message.event as? GameEvent {
                handleGameEvent(gameEvent)
            }
        }
    }
    
    func update(_ delta: TimeInterval) {
        if !running { return }
        parallax?.update(delta)
    }
    
    private func handleInputEvent() {
        // delegate to a state machine here.
        // in the stopped state, input means transition to the running state
        // in the running state, input goes to the player state machine
        running = !running
    }
    
    private func handleGameEvent(_ event: GameEvent) {
        switch event {
        case .gameStart:
            print("game start")
        case .gameOver:
            print("game over")
        }
    }
    
    private func spawnParallax() {
        guard let factory = container.factory, let scene = container.scene, let sceneWidth = scene.view?.bounds.width else { return }
        
        parallax = ParallaxRowSystem(maxSpeed: GameConstants.maxSpeed)
                
        let rows: [EntityPrototype] = [
            .parallaxRow(.cycling([.debug(.dark), .debug(.light)], ParallaxRowParameters(distance: 0.25, width: sceneWidth, y: 48))),
            .parallaxRow(.cycling([.debug(.light), .debug(.dark)], ParallaxRowParameters(distance: 0.5, width: sceneWidth, y: 32))),
            .parallaxRow(.cycling([.debug(.dark), .debug(.light)], ParallaxRowParameters(distance: 1, width: sceneWidth, y: 0))),
            .parallaxRow(.cycling([.debug(.light), .debug(.dark)], ParallaxRowParameters(distance: 2, width: sceneWidth, y: -64))),
        ]
        
        parallax?.spawn(rows, on: scene, from: factory)
    }
}
