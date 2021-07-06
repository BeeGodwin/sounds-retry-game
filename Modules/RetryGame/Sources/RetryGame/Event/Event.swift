import Foundation

struct EventMessage: EventProtocol {
    var channel: EventChannel
    var event: Event
}

public protocol Event { }

enum InputEvent: Event {
    case touched
}

enum GameEvent: Event {
    case gameStart
    case gameOver
    case gameReady
}

enum ControlEvent: Event {
    case playerAction
}

enum ScoreEvent: Event {
    case incrementBy(Int)
    case reset
}
