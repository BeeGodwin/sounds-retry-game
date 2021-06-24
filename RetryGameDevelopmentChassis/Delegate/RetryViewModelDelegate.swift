//
//  RetryViewModelDelegate.swift
//  RetryGameDevelopmentChassis
//
//  Created by Bee Godwin on 24/06/2021.
//

import Foundation

protocol RetryViewModelDelegate {
    func retry(_ vm: RetryViewModelProtocol)
    func navigateToDownloads(_ vm: RetryViewModelProtocol)
}

class StubRetryViewModelDelegate: RetryViewModelDelegate {
    func retry(_ vm: RetryViewModelProtocol) {
        print("stub retry called")
    }
    
    func navigateToDownloads(_ vm: RetryViewModelProtocol) {
        print("stub navigate called")
    }
}
