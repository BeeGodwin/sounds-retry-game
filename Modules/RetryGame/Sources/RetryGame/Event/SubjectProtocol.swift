import Foundation

protocol SubjectProtocol {
    func subscribe(to channel: EventChannel, with observer: ObserverProtocol)
    func unsubscribe(from channel: EventChannel, with observer: ObserverProtocol)
    func notify(of event: EventProtocol)
}
