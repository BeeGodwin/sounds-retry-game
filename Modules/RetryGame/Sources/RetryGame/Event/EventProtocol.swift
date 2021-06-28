import Foundation

public protocol EventProtocol {
    var channel: EventChannel { get }
    var event: Event { get }
}
