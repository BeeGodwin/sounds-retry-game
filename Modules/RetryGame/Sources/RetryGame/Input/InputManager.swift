import Foundation

enum InputEvent: Event {
    case touched
}

class InputManager {
    
    let eventBus: EventBus
        
    init(eventBus: EventBus) {
        self.eventBus = eventBus
    }
    
    func touchStart() { }
    
    func touchEnd() {
        let event = EventMessage(channel: .input, event: InputEvent.touched)
        eventBus.notify(of: event)
    }
}
