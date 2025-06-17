//
//  GFRepoCell.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 16/06/25.
//

import UIKit
import GithubFollowers

class GFRepoCell: UITableViewCell {
    
    static let reuseID = "GFRepoCell"
    
    let repoNameLabel = GFTitleLabel(textAlignment: .left, fontSize: 16)
    let languageLabel = GFSecondaryTitleLabel(fontSize: 14)
    let starsLabel = GFSecondaryTitleLabel(fontSize: 14)
    let descriptionLabel = GFBodyLabel(textAlignment: .left)
    
    let starImageView = UIImageView()
    let codeImageView = UIImageView()
    
    private let padding: CGFloat = 12
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(repo: Repo) {
        repoNameLabel.text = repo.name
        languageLabel.text = repo.language ?? LocalizedStringHelper.unknown
        starsLabel.text = "\(repo.stars)"
        descriptionLabel.text = repo.description ?? LocalizedStringHelper.noDescriptionAvailable
    }
    
    private func configure() {
        accessoryType = .disclosureIndicator
        
        // Configure image views
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .systemYellow
        starImageView.contentMode = .scaleAspectFit
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        
        codeImageView.image = SFSymbols.code
        codeImageView.tintColor = .systemGray
        codeImageView.contentMode = .scaleAspectFit
        codeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure labels
        descriptionLabel.numberOfLines = 2
        
        contentView.addSubviews(repoNameLabel, languageLabel, codeImageView, starsLabel, starImageView, descriptionLabel)
        
        NSLayoutConstraint.activate([
            repoNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            repoNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            repoNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            repoNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            codeImageView.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 5),
            codeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            codeImageView.widthAnchor.constraint(equalToConstant: 20),
            codeImageView.heightAnchor.constraint(equalToConstant: 20),
            
            languageLabel.centerYAnchor.constraint(equalTo: codeImageView.centerYAnchor),
            languageLabel.leadingAnchor.constraint(equalTo: codeImageView.trailingAnchor, constant: 5),
            languageLabel.widthAnchor.constraint(equalToConstant: 100),
            languageLabel.heightAnchor.constraint(equalToConstant: 20),
            
            starImageView.centerYAnchor.constraint(equalTo: codeImageView.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor, constant: 10),
            starImageView.widthAnchor.constraint(equalToConstant: 20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),
            
            starsLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            starsLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 5),
            starsLabel.widthAnchor.constraint(equalToConstant: 50),
            starsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: codeImageView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}

