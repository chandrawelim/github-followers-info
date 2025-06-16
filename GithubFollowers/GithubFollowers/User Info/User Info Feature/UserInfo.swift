//
//  UserInfo.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

import Foundation

public struct UserInfo: Equatable {
    public let login: String
    public let avatarUrl: URL
    public let name: String?
    public let followers: Int
    public let following: Int
    public let location: String?
    public let bio: String?
    public let htmlUrl: String
    
    public init(login: String, avatarUrl: URL, name: String?, followers: Int, following: Int, location: String?, bio: String?, htmlUrl: String) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.followers = followers
        self.following = following
        self.location = location
        self.bio = bio
        self.htmlUrl = htmlUrl
    }
}
