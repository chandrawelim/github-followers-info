//
//  SceneDelegate.swift
//  GithubFollowersApp
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit
import GithubFollowers
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var baseURL = URL(string: Config.baseURL)!

    private lazy var navigationController = UINavigationController(
        rootViewController: SearchUIComposer.searchComposed(
            followerLoader: makeFollowerLoader(),
            userInfoLoader: makeUserInfoLoader(),
            repoLoader: makeRepoLoader()
        )
    )
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        configureWindow()
        configureNavigationBar()
    }
    
    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    private func makeFollowerLoader() -> (String, Int) -> AnyPublisher<[Follower], Error> {
        return { [httpClient, baseURL] username, page in
            let url = FollowerEndpoint.getFollowers(username: username, page: page).url(baseURL: baseURL)
            
            return httpClient
                .getPublisher(url: url)
                .tryMap(FollowerMapper.map)
                .eraseToAnyPublisher()
        }
    }
    
    private func makeUserInfoLoader() -> (String) -> AnyPublisher<UserInfo, Error> {
        return { [httpClient, baseURL] username in
            let url = UserInfoEndpoint.get(username: username).url(baseURL: baseURL)
            
            return httpClient
                .getPublisher(url: url)
                .tryMap(UserInfoMapper.map)
                .eraseToAnyPublisher()
        }
    }
    private func makeRepoLoader() -> (String) -> AnyPublisher<[Repo], Error> {
        return { [httpClient, baseURL] username in
            let url = RepositoryEndpoint.get(username: username).url(baseURL: baseURL)
            
            return httpClient
                .getPublisher(url: url)
                .tryMap(RepositoryMapper.map)
                .eraseToAnyPublisher()
        }
    }
}
