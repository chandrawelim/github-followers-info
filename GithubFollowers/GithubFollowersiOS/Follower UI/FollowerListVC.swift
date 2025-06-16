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
    var followers: [Follower] = []
    var page: Int = 1
    
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
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }
    
    func getFollowers(username: String, page: Int) {
        followerPresenter?.loadFollowers(username: username, page: page) { [weak self] followers in
            guard let self = self else { return }
            
            self.updateUI(with: followers)
        }
    }
    
    func updateUI(with followers: [Follower]) {
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers, Go follow them 😀."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
                return
            }
        }
        self.updateData(on: self.followers)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = followers[indexPath.item]
        
        let userInfoVC = makeUserInfoVC(follower.login)
        let navController = UINavigationController(rootViewController: userInfoVC)
        present(navController, animated: true)
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
