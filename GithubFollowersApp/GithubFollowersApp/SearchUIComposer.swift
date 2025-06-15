//
//  SearchUIComposer.swift
//  GithubFollowersApp
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit
import GithubFollowers
import GithubFollowersiOS

class SearchUIComposer {
    static func searchComposed() -> SearchVC {
        let searchVC = SearchVC()
        searchVC.createFollowerListVC = { username in
            return UIViewController()
        }
        return searchVC
    }
}

