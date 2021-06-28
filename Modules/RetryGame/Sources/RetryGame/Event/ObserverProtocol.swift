import Foundation

public protocol ObserverProtocol: AnyObject {
    func receiveEvent(_ event: EventProtocol)
}
