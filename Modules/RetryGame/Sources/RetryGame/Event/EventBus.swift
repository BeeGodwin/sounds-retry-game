import Foundation

public class EventBus: EventBusProtocol {
        
    lazy var channels = [EventChannel: [ObserverProtocol]]()
    
    public func subscribe(to channel: EventChannel, with observer: ObserverProtocol) {
        if channels[channel] == nil {
            channels[channel] = [observer]
            return
        }
        if (channels[channel]?.firstIndex(where: { $0 === observer })) != nil { return }
        
        channels[channel]?.append(observer)
    }
    
    public func unsubscribe(from channel: EventChannel, with observer: ObserverProtocol) {
        if let idx = channels[channel]?.firstIndex(where: { $0 === observer }) {
            channels[channel]?.remove(at: idx)
        }
    }

    public func notify(of event: EventProtocol) {
        if let observers = channels[event.channel] {
            observers.forEach { $0.receiveEvent(event) }
        }
    }
}
