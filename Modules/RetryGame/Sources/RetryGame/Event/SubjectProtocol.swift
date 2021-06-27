import Foundation

protocol SubjectProtocol {
    func attach(_ observer: ObserverProtocol) -> Void
    func detatch(_ observer: ObserverProtocol) -> Void
    func notifyObservers(of message: EventProtocol)
}
