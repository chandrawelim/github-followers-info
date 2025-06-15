//
//  LoadingPresenter.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

import Foundation

public final class LoadingPresenter {
    private let loadingView: ResourceLoadingView
    
    public init(loadingView: ResourceLoadingView) {
        self.loadingView = loadingView
    }
    
    func didStartLoading() {
        loadingView.display(ResourceLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoading() {
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
    }
}

