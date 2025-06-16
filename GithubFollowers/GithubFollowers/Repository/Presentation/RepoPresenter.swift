//
//  RepoPresenter.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

import Foundation
import Combine

public final class RepoPresenter {
    private let repoLoader: (String) -> AnyPublisher<[Repo], Error>
    private let errorPresenter: ErrorPresenter
    
    public init(
        repoLoader: @escaping (String) -> AnyPublisher<[Repo], Error>,
        errorPresenter: ErrorPresenter
    ) {
        self.repoLoader = repoLoader
        self.errorPresenter = errorPresenter
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    public func loadRepositories(username: String, completion: @escaping ([Repo]) -> Void) {
        repoLoader(username)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completionStatus in
                    guard let self = self else { return }
                    if case let .failure(error) = completionStatus {
                        self.errorPresenter.didReceiveError(error)
                        completion([])
                    }
                },
                receiveValue: { [weak self] repos in
                    guard let self = self else { return }
                    self.errorPresenter.didSucceed()
                    completion(repos)
                }
            )
            .store(in: &cancellables)
    }
}
