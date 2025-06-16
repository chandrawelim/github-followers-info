//
//  GFRepoItemVC.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 16/06/25.
//

import UIKit
import GithubFollowers

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: UserInfo)
}

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemVCDelegate!
    
    init(user: UserInfo, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _configureItems()
    }
    
    private func _configureItems() {
        itemInfoViewOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: .followers, withCount: user.followers)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}

