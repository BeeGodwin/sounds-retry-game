import Foundation

class EventBus: SubjectProtocol {
    
    private lazy var observers = [ObserverProtocol]()
    
    func subscribe(_ observer: ObserverProtocol) {
        observers.append(observer)
    }
    
    func unsubscribe(_ observer: ObserverProtocol) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: idx)
        }
    }
    
    func notify(_ event: EventProtocol) {
        observers.forEach { $0.receiveEvent(event) }
    }
}
