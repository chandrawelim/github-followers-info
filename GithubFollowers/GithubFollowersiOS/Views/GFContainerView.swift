//
//  GFContainerView.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit

class GFContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        _configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}


