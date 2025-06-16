//
//  UserInfoPresenter.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

import Foundation
import Combine

public final class UserInfoPresenter {
    private let userInfoLoader: (String) -> AnyPublisher<UserInfo, Error>
    private let loadingPresenter: LoadingPresenter
    private let errorPresenter: ErrorPresenter
    
    public init(
        userInfoLoader: @escaping (String) -> AnyPublisher<UserInfo, Error>,
        loadingPresenter: LoadingPresenter,
        errorPresenter: ErrorPresenter
    ) {
        self.userInfoLoader = userInfoLoader
        self.loadingPresenter = loadingPresenter
        self.errorPresenter = errorPresenter
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    public func loadUserInfo(username: String, completion: @escaping (UserInfo) -> Void) {
        loadingPresenter.didStartLoading()
        
        userInfoLoader(username)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completionStatus in
                    guard let self = self else { return }
                    self.loadingPresenter.didFinishLoading()
                    
                    if case let .failure(error) = completionStatus {
                        self.errorPresenter.didReceiveError(error)
                    }
                },
                receiveValue: { [weak self] userInfo in
                    guard let self = self else { return }
                    self.errorPresenter.didSucceed()
                    completion(userInfo)
                }
            )
            .store(in: &cancellables)
    }
}
