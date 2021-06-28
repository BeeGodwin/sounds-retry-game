import Foundation

enum InputEvent: Event {
    case touched
}

class InputManager {
    
    private let eventBus: EventBusProtocol
        
    init(eventBus: EventBusProtocol) {
        self.eventBus = eventBus
    }
    
    func touchStart() { }
    
    func touchEnd() {
        let event = EventMessage(channel: .input, event: InputEvent.touched)
        eventBus.notify(of: event)
    }
}
