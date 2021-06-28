import XCTest
@testable import RetryGame

final class GameViewTests: XCTestCase {
    var view: GameView!
    var stubInputManager: StubInputManager!
    
    override func setUp() {
        view = GameView()
        stubInputManager = StubInputManager(eventBus: StubEventBus())
        view.inputManager = stubInputManager
    }
    
    func testTouchEndCallsInputManager() {
        view.touchesBegan(Set(), with: nil)
        XCTAssertEqual(stubInputManager.touchStartCallCount, 1)
    }
    
    func testTouchStartCallsInputManager() {
        view.touchesEnded(Set(), with: nil)
        XCTAssertEqual(stubInputManager.touchEndCallCount, 1)
    }
}
