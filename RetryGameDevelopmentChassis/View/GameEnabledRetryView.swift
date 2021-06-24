//
//  GameEnabledRetryView.swift
//  RetryGameDevelopmentChassis
//
//  Created by Bee Godwin on 24/06/2021.
//

import SpriteKit
import RetryGame

class GameEnabledRetryView: SKView {
    
    var retryViewModel: RetryViewModelProtocol! = StubRetryViewModel() // handled by the RetryViewFactory in the main app
    var gameContainer: RetryGameContainer! = RetryGameContainer()
}
