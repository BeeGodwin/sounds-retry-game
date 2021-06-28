import Foundation

protocol EventProtocol {
    var channel: EventChannel { get }
    var event: Event { get }
}
