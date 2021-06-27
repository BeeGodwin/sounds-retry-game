import Foundation

class InputManager: SubjectProtocol {
    
    private lazy var observers = [ObserverProtocol]()
    
    func attach(_ observer: ObserverProtocol) {
        observers.append(observer)
    }
    
    func detatch(_ observer: ObserverProtocol) {
        if let idx = observers.firstIndex(where: {$0 === observer}) {
            observers.remove(at: idx)
        }
    }
    
    func notifyObservers(of event: EventProtocol) {
        observers.forEach { $0.receiveEvent(event)}
    }
    
    func touchStart() {
    }
    
    func touchEnd() {
        let event = GameTouchedEvent(channel: "game", id: "game_touched")
        notifyObservers(of: event)
    }
}
