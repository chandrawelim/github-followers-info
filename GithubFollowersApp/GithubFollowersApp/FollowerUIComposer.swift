//
//  FollowerUIComposer.swift
//  GithubFollowersApp
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit
import GithubFollowers
import GithubFollowersiOS
import Combine

final class FollowerUIComposer {
    
    static func followersComposedWith(
        username: String,
        followerLoader: @escaping (String, Int) -> AnyPublisher<[Follower], Error>,
        userInfoLoader: @escaping (String) -> AnyPublisher<UserInfo, Error>,
        repoLoader: @escaping (String) -> AnyPublisher<[Repo], Error>
    ) -> FollowerListVC {
        let followerListVC = FollowerListVC(username: username)
        
        let loadingPresenter = LoadingPresenter(loadingView: WeakRefVirtualProxy(followerListVC))
        let errorPresenter = ErrorPresenter(errorView: WeakRefVirtualProxy(followerListVC))
        
        let followerPresenter = FollowerPresenter(
            followerLoader: followerLoader,
            loadingPresenter: loadingPresenter,
            errorPresenter: errorPresenter
        )
            
        followerListVC.followerPresenter = followerPresenter
        followerListVC.makeUserInfoVC = { username in
            return UserInfoUIComposer.userInfoComposed(
                username: username,
                userInfoLoader: userInfoLoader,
                repoLoader: repoLoader
            )
        }
        
        return followerListVC
    }
}

