import Foundation

protocol GameEvent: EventProtocol {}

struct GameTouchedEvent: GameEvent {
    
    var channel = "game"
    
    var id: String

}
