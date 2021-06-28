
import XCTest
@testable import RetryGame

final class EventBusTests: XCTestCase {
   
    var eventBus: EventBus!
    
    override func setUp() {
        eventBus = EventBus()
    }
    
    func testSubscribeAddsObserver() {
        let stubObserver = StubObserver()
        eventBus.subscribe(to: .input, with: stubObserver)
        XCTAssertEqual(eventBus!.channels[.input]?.count, 1)
        let secondStubObserver = StubObserver()
        eventBus.subscribe(to: .input, with: secondStubObserver)
        XCTAssertEqual(eventBus!.channels[.input]?.count, 2)
    }
    
    func testUnsubscribeRemovesObserver() {
        let stubObserver = StubObserver()
        eventBus.subscribe(to: .input, with: stubObserver)
        XCTAssertEqual(eventBus!.channels[.input]?.count, 1)
        eventBus.unsubscribe(from: .input, with: stubObserver)
        XCTAssertEqual(eventBus!.channels[.input]?.count, 0)
    }
    
    func testSubscribingTwiceDoesNotDuplicate() {
        let stubObserver = StubObserver()
        eventBus.subscribe(to: .input, with: stubObserver)
        eventBus.subscribe(to: .input, with: stubObserver)
        XCTAssertEqual(eventBus!.channels[.input]?.count, 1)
    }
    
    func testUnsubscribingNotSubscribedObserverFailsGracefully() {
        let stubObserver = StubObserver()
        eventBus.unsubscribe(from: .input, with: stubObserver)
        XCTAssertEqual(eventBus!.channels[.input]?.count, nil)
    }
    
    func testNotifyNotifiesSubscribers() {
        let stubObserver = StubObserver()
        eventBus.subscribe(to: .input, with: stubObserver)
        
        let event = EventMessage(channel: .input, event: InputEvent.touched)
        eventBus.notify(of: event)
        
        XCTAssertEqual(stubObserver.receiveEventCallCount, 1)
        XCTAssertEqual(stubObserver.reciveEventParameter!.event as! InputEvent, InputEvent.touched)
    }
}
