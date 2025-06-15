//
//  Follower.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

import Foundation

public struct Follower: Hashable {
    
    public let login: String
    public let avatarUrl: URL?

    public init(login: String,
                avatarUrl: URL?) {
        self.login = login
        self.avatarUrl = avatarUrl
    }
}

