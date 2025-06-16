//
//  Repo.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

import Foundation

public struct Repo: Equatable, Hashable {
    
    public let name: String
    public let language: String?
    public let stars: Int
    public let description: String?
    public let url: String
    
    public init(name: String, language: String? = nil, stars: Int, description: String? = nil, url: String) {
        self.name = name
        self.language = language
        self.stars = stars
        self.description = description
        self.url = url
    }
}
