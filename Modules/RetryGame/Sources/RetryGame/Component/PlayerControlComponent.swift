import GameplayKit

enum PlayerJumpState {
    case jumping
    case grounded
}

class PlayerControlComponent: GKComponent, ObserverProtocol {
    
    let eventBus: EventBusProtocol
    let physicsBody: SKPhysicsBody
    var jumpState: PlayerJumpState = .grounded
    
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
        case .jump:
            handleJump()
        case .land:
            handleLanding()
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
    
    private func handleJump() {
        if case .grounded = jumpState {
            physicsBody.velocity = CGVector(dx: 0, dy: GameConstants.jumpForce)
            jumpState = .jumping
        }
    }
    
    private func handleLanding() {
        jumpState = .grounded
    }
}

extension Entity {
    func addPlayerControlComponent(_ component: PlayerControlComponent) {
        self.addComponent(component)
    }
}
