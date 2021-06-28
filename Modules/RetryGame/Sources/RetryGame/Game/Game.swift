import Foundation

class Game: ObserverProtocol {
    
    let eventBus: EventBus
    
    init(eventBus: EventBus) {
        self.eventBus = eventBus
        eventBus.subscribe(self)
        print("game initialised")
    }
    
    func receiveEvent(_ message: EventProtocol) {
        print("\(message.channel) : \(message.event)")
    }
}
