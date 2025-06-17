//
//  RepoPresenter.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

import Foundation
import Combine

public protocol RepoView: AnyObject {
    func displayRepositories(_ repositories: [Repo])
    func displayEmptyState(message: String)
}

public final class RepoPresenter {
    private let repoLoader: (String) -> AnyPublisher<[Repo], Error>
    private let errorPresenter: ErrorPresenter
    private weak var view: RepoView?
    private var repositories: [Repo] = []
    
    public init(
        repoLoader: @escaping (String) -> AnyPublisher<[Repo], Error>,
        errorPresenter: ErrorPresenter
    ) {
        self.repoLoader = repoLoader
        self.errorPresenter = errorPresenter
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    public func set(view: RepoView) {
        self.view = view
    }
    
    public func loadRepositories(username: String) {
        repoLoader(username)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completionStatus in
                    guard let self = self else { return }
                    if case let .failure(error) = completionStatus {
                        self.errorPresenter.didReceiveError(error)
                    }
                },
                receiveValue: { [weak self] repos in
                    guard let self = self else { return }
                    self.errorPresenter.didSucceed()
                    
                    self.repositories = repos
                    
                    if self.repositories.isEmpty {
                        self.view?.displayEmptyState(message: NSLocalizedString("no_repositories_message",
                                                                                tableName: "BusinessLogic",
                                                                                bundle: Bundle(for: Self.self),
                                                                                comment: "Empty state for follower"))
                    } else {
                        self.view?.displayRepositories(self.repositories)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    public func repository(at index: Int) -> Repo? {
        guard index >= 0 && index < repositories.count else { return nil }
        return repositories[index]
    }
}
