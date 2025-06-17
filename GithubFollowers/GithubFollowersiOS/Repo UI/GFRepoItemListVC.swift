//
//  GFRepoItemListVC.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 16/06/25.
//

import UIKit
import GithubFollowers
import Combine

class GFRepoItemListVC: GFDataLoadingVC {
    
    enum Section { case main }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Repo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Repo>
    
    let tableView = UITableView()
    let headerView = UIView()
    let headerLabel = GFTitleLabel(textAlignment: .left, fontSize: 18)
    let repoImageView = UIImageView()
    
    var dataSource: DataSource!
    var username: String!
    
    private var presenter: RepoPresenter?
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderView()
        configureTableView()
        configureDataSource()
        presenter?.set(view: self)
        loadRepositories()
    }
    
    func set(presenter: RepoPresenter) {
        self.presenter = presenter
    }
    
    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubviews(repoImageView, headerLabel)
        
        repoImageView.image = SFSymbols.repository
        repoImageView.tintColor = .systemGreen
        repoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.text = LocalizedStringHelper.repositories
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
            
            repoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            repoImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: padding),
            repoImageView.widthAnchor.constraint(equalToConstant: 24),
            repoImageView.heightAnchor.constraint(equalToConstant: 24),
            
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: repoImageView.trailingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -padding),
            headerLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 110
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.register(GFRepoCell.self, forCellReuseIdentifier: GFRepoCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, repo in
            let cell = tableView.dequeueReusableCell(withIdentifier: GFRepoCell.reuseID) as! GFRepoCell
            cell.set(repo: repo)
            return cell
        }
    }
    
    private func loadRepositories() {
        guard let username = username else { return }
        presenter?.loadRepositories(username: username)
    }
    
    private func updateData(with repos: [Repo]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(repos)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension GFRepoItemListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let repo = presenter?.repository(at: indexPath.row) else { return }
        guard let url = URL(string: repo.url) else { return }
        presentSafariVC(with: url)
    }
}

// MARK: - RepoView
extension GFRepoItemListVC: RepoView {
    public func displayRepositories(_ repositories: [Repo]) {
        updateData(with: repositories)
    }
    
    public func displayEmptyState(message: String) {
        showEmptyStateView(with: message, in: view)
    }
}

extension GFRepoItemListVC: ResourceErrorView {
    public func display(_ viewModel: ResourceErrorViewModel) {
        if let message = viewModel.message {
            presentGFAlertOnMainThread(title: LocalizedStringHelper.errorTitle, message: message, buttonTitle: LocalizedStringHelper.okButton)
        }
    }
}
