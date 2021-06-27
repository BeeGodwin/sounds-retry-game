import Foundation

protocol ObserverProtocol: AnyObject {
    func receiveEvent(_ event: EventProtocol)
}
