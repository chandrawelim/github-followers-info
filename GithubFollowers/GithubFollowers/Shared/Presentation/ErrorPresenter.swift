//
//  ErrorPresenter.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

import Foundation

public final class ErrorPresenter {
    private let errorView: ResourceErrorView
    
    public init(errorView: ResourceErrorView) {
        self.errorView = errorView
    }
    
    func didReceiveError(_ error: Error) {
        errorView.display(.error(message: error.localizedDescription))
    }
    
    func didReceiveError(message: String) {
        errorView.display(.error(message: message))
    }
    
    func didSucceed() {
        errorView.display(.noError)
    }
}

