import GameplayKit

class PlayerControlComponent: GKComponent, ObserverProtocol {

    let eventBus: EventBusProtocol
    
    init(eventBus: EventBusProtocol) {
        self.eventBus = eventBus
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
            print("player action")
        }
    }
}

extension Entity {
    func addPlayerControlComponent(_ component: PlayerControlComponent) {
        self.addComponent(component)
    }
}
