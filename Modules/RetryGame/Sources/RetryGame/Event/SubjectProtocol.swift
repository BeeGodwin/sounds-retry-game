import Foundation

protocol SubjectProtocol {
    func subscribe(_ observer: ObserverProtocol) -> Void
    func unsubscribe(_ observer: ObserverProtocol) -> Void
    func notify(_ event: EventProtocol)
}
