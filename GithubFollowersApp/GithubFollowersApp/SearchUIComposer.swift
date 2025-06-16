//
//  SearchUIComposer.swift
//  GithubFollowersApp
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit
import Combine
import GithubFollowers
import GithubFollowersiOS

class SearchUIComposer {
    static func searchComposed(
        followerLoader: @escaping (String, Int) -> AnyPublisher<[Follower], Error>,
        userInfoLoader: @escaping (String) -> AnyPublisher<UserInfo, Error>
    ) -> SearchVC {
        let searchVC = SearchVC()
        searchVC.createFollowerListVC = { username in
            return FollowerUIComposer.followersComposedWith(
                username: username,
                followerLoader: followerLoader,
                userInfoLoader: userInfoLoader
            )
        }
        return searchVC
    }
}
