import Foundation

class EventBus: SubjectProtocol {
        
    private lazy var channels = [EventChannel: [ObserverProtocol]]()
    
    func subscribe(to channel: EventChannel, with observer: ObserverProtocol) {
        if var observers = channels[channel] {
            observers.append(observer)
        } else {
            channels[channel] = [observer]
        }
    }
    
    func unsubscribe(from channel: EventChannel, with observer: ObserverProtocol) {
        guard var observers = channels[channel] else { return }
        if let idx = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: idx)
        }
    }
    

    func notify(of event: EventProtocol) {
        if let observers = channels[event.channel] {
            observers.forEach { $0.receiveEvent(event) }
        }
    }
}
