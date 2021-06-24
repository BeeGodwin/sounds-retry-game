//
//  RetryViewModel.swift
//  RetryGameDevelopmentChassis
//
//  Created by Bee Godwin on 24/06/2021.
//

import Foundation

protocol RetryViewModelProtocol {
    var delegate: RetryViewModelDelegate? { get set }
    var showDownloads: Bool { get }
    var message: String { get }
    func retryTapped()
    func downloadsTapped()
}

class StubRetryViewModel: RetryViewModelProtocol {
    
    var delegate: RetryViewModelDelegate?
    
    var showDownloads = false
    
    var message = "should not be seeing this"
    
    init() {
        delegate = StubRetryViewModelDelegate()
    }
    
    func retryTapped() {
        delegate?.retry(self)
    }
    
    func downloadsTapped() {
        delegate?.navigateToDownloads(self)
    }
}
