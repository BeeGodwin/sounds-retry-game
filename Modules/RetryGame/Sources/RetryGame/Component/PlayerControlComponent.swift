import GameplayKit

class PlayerControlComponent: GKComponent, ObserverProtocol {
    
    let eventBus: EventBusProtocol
    let physicsBody: SKPhysicsBody
    
    init(eventBus: EventBusProtocol, physicsBody: SKPhysicsBody) {
        self.eventBus = eventBus
        self.physicsBody = physicsBody
        super.init()
        eventBus.subscribe(to: .control, with: self)
        eventBus.subscribe(to: .game, with: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func receiveEvent(_ message: EventProtocol) {
        switch message.channel {
        case .control:
            if let controlEvent = message.event as? ControlEvent { handleControlEvent(controlEvent) }
        case .game:
            if let gameEvent = message.event as? GameEvent { handleGameEvent(gameEvent) }
        default:
            print("unhandled event")
        }
        
    }
    
    private func handleControlEvent(_ event: ControlEvent) {
        switch event {
        case .playerAction:
            // TODO: resolve multi-jump bug
            physicsBody.velocity = CGVector(dx: 0, dy: GameConstants.jumpForce)
        }
    }
    
    private func handleGameEvent(_ event: GameEvent) {
        switch event {
        case .gameOver:
            physicsBody.isDynamic = false
        case .gameReady, .gameStart:
            physicsBody.isDynamic = true
        }
    }
}

extension Entity {
    func addPlayerControlComponent(_ component: PlayerControlComponent) {
        self.addComponent(component)
    }
}
