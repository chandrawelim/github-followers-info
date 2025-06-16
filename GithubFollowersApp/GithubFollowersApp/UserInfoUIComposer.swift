//
//  UserInfoUIComposer.swift
//  GithubFollowersApp
//
//  Created by Chandra Welim on 16/06/25.
//

import UIKit
import Combine
import GithubFollowers
import GithubFollowersiOS

public final class UserInfoUIComposer {
    
    public static func userInfoComposed(
        username: String,
        userInfoLoader: @escaping (String) -> AnyPublisher<UserInfo, Error>,
        repoLoader: @escaping (String) -> AnyPublisher<[Repo], Error>
    ) -> UserInfoVC {
        
        let userInfoVC = UserInfoVC()
        
        let loadingPresenter = LoadingPresenter(loadingView: WeakRefVirtualProxy(userInfoVC))
        let errorPresenter = ErrorPresenter(errorView: WeakRefVirtualProxy(userInfoVC))
        
        let presenter = UserInfoPresenter(
            userInfoLoader: userInfoLoader,
            loadingPresenter: loadingPresenter,
            errorPresenter: errorPresenter
        )
        
        let repoPresenter = RepoPresenter(
            repoLoader: repoLoader,
            errorPresenter: errorPresenter
        )
        
        userInfoVC.username = username
        userInfoVC.userInfoPresenter = presenter
        userInfoVC.set(repoPresenter: repoPresenter)
        
        return userInfoVC
    }
}
