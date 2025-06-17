//
//  FollowerListVC.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit
import GithubFollowers

public class FollowerListVC: GFDataLoadingVC {
    
    enum Section {
        case main
    }
    
    var username: String!
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    public var followerPresenter: FollowerPresenter?
    public var makeUserInfoVC: (String) -> UIViewController = { _ in UIViewController() }
    
    public init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        followerPresenter?.set(view: self)
        loadFollowers()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func loadFollowers() {
        followerPresenter?.loadFollowers(username: username)
    }
    
    private func updateData(with followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let follower = followerPresenter?.follower(at: indexPath.item) else { return }
        
        let userInfoVC = makeUserInfoVC(follower.login)
        let navController = UINavigationController(rootViewController: userInfoVC)
        present(navController, animated: true)
    }
}

// MARK: - FollowerView
extension FollowerListVC: FollowerView {
    public func displayFollowers(_ followers: [Follower]) {
        updateData(with: followers)
    }
    
    public func displayEmptyState(message: String) {
        showEmptyStateView(with: message, in: view)
    }
}

// MARK: - ResourceLoadingView
extension FollowerListVC: ResourceLoadingView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        if viewModel.isLoading {
            showLoadingView()
        } else {
            dismissLoadingView()
        }
    }
}

// MARK: - ResourceErrorView
extension FollowerListVC: ResourceErrorView {
    public func display(_ viewModel: ResourceErrorViewModel) {
        if let message = viewModel.message {
            presentGFAlertOnMainThread(title: "Error", message: message, buttonTitle: "OK")
        }
    }
}
