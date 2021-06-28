@testable import RetryGame

class StubInputManager: InputManager {
    
    var touchStartCallCount = 0

    override func touchStart() {
        touchStartCallCount += 1
    }
    
    var touchEndCallCount = 0
    
    override func touchEnd() {
        touchEndCallCount += 1
    }
}
