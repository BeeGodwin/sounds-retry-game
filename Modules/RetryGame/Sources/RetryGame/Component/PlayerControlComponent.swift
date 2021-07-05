import GameplayKit

class PlayerControlComponent: GKComponent, ObserverProtocol {

    let eventBus: EventBusProtocol
    let physicsBody: SKPhysicsBody
    
    init(eventBus: EventBusProtocol, physicsBody: SKPhysicsBody) {
        self.eventBus = eventBus
        self.physicsBody = physicsBody
        super.init()
        eventBus.subscribe(to: .control, with: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func receiveEvent(_ event: EventProtocol) {
        guard let controlEvent = event.event as? ControlEvent else { return }
        switch controlEvent {
        case .playerAction:
            physicsBody.velocity = CGVector(dx: 0, dy: GameConstants.jumpForce)
        }
    }
}

extension Entity {
    func addPlayerControlComponent(_ component: PlayerControlComponent) {
        self.addComponent(component)
    }
}
