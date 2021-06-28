import XCTest
@testable import RetryGame

final class InputManagerTests: XCTestCase {
    
    var inputManager: InputManager! = nil
    var eventBus: StubEventBus? = nil
    
    
    override func setUp() {
        eventBus = StubEventBus()
        inputManager = InputManager(eventBus: eventBus!)
    }
    
    func testTouchEndNotifiesEventBus() {
        inputManager.touchEnd()
        let expectedEvent = EventMessage(channel: .input, event: InputEvent.touched)
        XCTAssertEqual(eventBus?.notifyCalledTimes, 1)
        XCTAssertEqual(expectedEvent.channel, .input)
        XCTAssertEqual(expectedEvent.event as! InputEvent, InputEvent.touched)
    }
    
    func testTouchStartDoesNotCrash() {
        inputManager.touchStart()
    }
}
