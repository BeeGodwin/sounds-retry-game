//
//  GameEndDelegate.swift
//  RetryGameDevelopmentChassis
//
//  Created by Bee Godwin on 25/06/2021.
//

import Foundation
import RetryGame

class RetryDelegate: RetryDelegateProtocol {
    
    var viewModel: RetryViewModelProtocol
    
    init(with vm: RetryViewModelProtocol) {
        viewModel = vm
    }
    
    func retry() {
        viewModel.retryTapped()
    }
}
