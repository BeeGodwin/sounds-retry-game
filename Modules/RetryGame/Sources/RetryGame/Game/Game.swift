import Foundation

class Game: ObserverProtocol {
    
    init() {
        print("game initialised")
    }
    
    func receiveEvent(_ message: EventProtocol) {
        print("\(message.channel) : \(message.id)")
    }
}
