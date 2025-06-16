//
//  UserInfoVC.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 16/06/25.
//

import UIKit
import GithubFollowers
import Combine

public class UserInfoVC: GFDataLoadingVC {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let repoListView = UIView()
    
    var itemViews: [UIView] = []
    
    public var username: String!
    public var userInfoPresenter: UserInfoPresenter?
    private var repoPresenter: RepoPresenter?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800) // Increased height for repo list
        ])
    }
    
    func getUserInfo() {
        guard let username = username else { return }
        userInfoPresenter?.loadUserInfo(username: username) { [weak self] userInfo in
            guard let self = self else { return }
            self.configureUIElements(with: userInfo)
        }
    }
    
    func configureUIElements(with user: UserInfo) {
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        
        let repoListVC = GFRepoItemListVC(username: user.login)
        if let repoPresenter = self.repoPresenter {
            repoListVC.set(presenter: repoPresenter)
            self.add(childVC: repoListVC, to: self.repoListView)
        }
    }
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, repoListView]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            repoListView.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            repoListView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            repoListView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    public func set(repoPresenter: RepoPresenter) {
        self.repoPresenter = repoPresenter
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: ResourceLoadingView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        if viewModel.isLoading {
            showLoadingView()
        } else {
            dismissLoadingView()
        }
    }
}

extension UserInfoVC: ResourceErrorView {
    public func display(_ viewModel: ResourceErrorViewModel) {
        if let message = viewModel.message {
            presentGFAlertOnMainThread(title: "Error", message: message, buttonTitle: "OK")
        }
    }
}

extension UserInfoVC: GFRepoItemVCDelegate {
    func didTapGitHubProfile(for user: UserInfo) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
}
