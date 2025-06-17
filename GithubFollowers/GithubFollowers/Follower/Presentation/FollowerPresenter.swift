//
//  FollowerPresenter.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

import Foundation
import Combine

public protocol FollowerView: AnyObject {
    func displayFollowers(_ followers: [Follower])
    func displayEmptyState(message: String)
}

public final class FollowerPresenter {
    private let followerLoader: (String, Int) -> AnyPublisher<[Follower], Error>
    private let loadingPresenter: LoadingPresenter
    private let errorPresenter: ErrorPresenter
    private weak var view: FollowerView?
    private var followers: [Follower] = []
    
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
    
    public func set(view: FollowerView) {
        self.view = view
    }
    
    public func loadFollowers(username: String) {
        loadingPresenter.didStartLoading()
        
        followerLoader(username, 1)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completionStatus in
                    guard let self = self else { return }
                    self.loadingPresenter.didFinishLoading()
                    
                    if case let .failure(error) = completionStatus {
                        self.errorPresenter.didReceiveError(error)
                    }
                },
                receiveValue: { [weak self] newFollowers in
                    guard let self = self else { return }
                    self.errorPresenter.didSucceed()
                    
                    self.followers.append(contentsOf: newFollowers)
                    
                    if self.followers.isEmpty {
                        self.view?.displayEmptyState(message: "This user doesn't have any followers, Go follow them 😀.")
                    } else {
                        self.view?.displayFollowers(self.followers)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    public func follower(at index: Int) -> Follower? {
        guard index >= 0 && index < followers.count else { return nil }
        return followers[index]
    }
}

