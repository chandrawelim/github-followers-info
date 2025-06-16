//
//  UserInfoEndpoint.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

public enum UserInfoEndpoint {
    case get(username: String)

    public func url(baseURL: URL) -> URL {
        switch self {
        case .get(let username):
            return baseURL.appendingPathComponent("/users/\(username)")
        }
    }
}

