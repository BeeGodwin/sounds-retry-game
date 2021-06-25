//
//  ViewController.swift
//  RetryGameDevelopmentChassis
//
//  Created by Bee Godwin on 24/06/2021.
//

import UIKit
import RetryGame

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let gameView = view as? GameEnabledRetryView else { return }
        
        let viewModel = StubRetryViewModel()
        let delegate = RetryDelegate(with: viewModel)
        gameView.gameContainer = GameContainer(on: gameView, with: delegate)
    }
}

fileprivate extension UIViewController {
    
}

