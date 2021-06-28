import Foundation

struct EventMessage: EventProtocol {
    var channel: EventChannel
    var event: Event
}

public protocol Event { }
