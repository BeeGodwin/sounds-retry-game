import Foundation

class InputManager {
    
    let eventBus: EventBus
        
    init(eventBus: EventBus) {
        self.eventBus = eventBus
    }
    
    func touchStart() { }
    
    func touchEnd() {
        let event = GameTouchedEvent(channel: "game", id: "game_touched")
        notify(of: event)
        eventBus.notify(event)
    }
}
