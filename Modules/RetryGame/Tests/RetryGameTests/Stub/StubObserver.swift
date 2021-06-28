import RetryGame

class StubObserver: ObserverProtocol {
    
    var receiveEventCallCount = 0
    var reciveEventParameter: EventProtocol?
    
    func receiveEvent(_ event: EventProtocol) {
        receiveEventCallCount += 1
        reciveEventParameter = event
    }
}
