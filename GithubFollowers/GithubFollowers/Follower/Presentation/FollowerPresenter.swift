//
//  FollowerPresenter.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

import Foundation
import Combine

public final class FollowerPresenter {
    private let followerLoader: (String, Int) -> AnyPublisher<[Follower], Error>
    private let loadingPresenter: LoadingPresenter
    private let errorPresenter: ErrorPresenter
    
    public init(
        followerLoader: @escaping (String, Int) -> AnyPublisher<[Follower], Error>,
        loadingPresenter: LoadingPresenter,
        errorPresenter: ErrorPresenter
    ) {
        self.followerLoader = followerLoader
        self.loadingPresenter = loadingPresenter
        self.errorPresenter = errorPresenter
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    public func loadFollowers(username: String, page: Int, completion: @escaping ([Follower]) -> Void) {
        loadingPresenter.didStartLoading()
        
        followerLoader(username, page)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completionStatus in
                    guard let self = self else { return }
                    self.loadingPresenter.didFinishLoading()
                    
                    if case let .failure(error) = completionStatus {
                        self.errorPresenter.didReceiveError(error)
                        completion([])
                    }
                },
                receiveValue: { [weak self] followers in
                    guard let self = self else { return }
                    self.errorPresenter.didSucceed()
                    completion(followers)
                }
            )
            .store(in: &cancellables)
    }
}

