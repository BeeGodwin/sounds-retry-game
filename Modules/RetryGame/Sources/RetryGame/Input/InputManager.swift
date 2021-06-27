import Foundation

class InputManager: SubjectProtocol {
    
    func attach(_ observer: ObserverProtocol) {
        print("attach")
    }
    
    func detatch(_ observer: ObserverProtocol) {
        print("detach")
    }
    
    func notifyObservers(of message: EventProtocol) {
        print("notify")
    }
    
    func touchStart() {
    }
    
    func touchEnd() {
        let event = GameTouchedEvent(channel: "game", id: "game_touched")
        notifyObservers(of: event)
    }
}
