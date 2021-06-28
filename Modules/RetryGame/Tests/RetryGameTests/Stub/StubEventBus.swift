//
//  File.swift
//  
//
//  Created by Bee Godwin on 28/06/2021.
//

import RetryGame

class StubEventBus: EventBusProtocol {
    
    var subscribeCalledTimes = 0
    var subscribeCalledChannelParam: EventChannel?
    var subscribeCalledObserverParam: ObserverProtocol?
    
    func subscribe(to channel: EventChannel, with observer: ObserverProtocol) {
        subscribeCalledTimes += 1
        subscribeCalledChannelParam = channel
        subscribeCalledObserverParam = observer
    }
    
    var unsubscribeCalledTimes = 0
    var unsubscribeCalledChannelParam: EventChannel?
    var unsubscribeCalledObserverParam: ObserverProtocol?
    
    func unsubscribe(from channel: EventChannel, with observer: ObserverProtocol) {
        unsubscribeCalledTimes += 1
        unsubscribeCalledChannelParam = channel
        unsubscribeCalledObserverParam = observer
    }
    
    var notifyCalledTimes = 0
    var notifyCalledEvent: EventProtocol?
    
    func notify(of event: EventProtocol) {
        notifyCalledTimes += 1
        notifyCalledEvent = event
    }
}
