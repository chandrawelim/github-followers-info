//
//  FollowerEndpoint.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

public enum FollowerEndpoint {
    case getFollowers(username: String, page: Int)

    public func url(baseURL: URL) -> URL {
        switch self {
        case .getFollowers(let username, let page):
            let userURL = baseURL.appendingPathComponent("/users/\(username)/followers")
            var components = URLComponents(url: userURL, resolvingAgainstBaseURL: true)!
            components.queryItems = [
                URLQueryItem(name: "per_page", value: "100"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            return components.url!
        }
    }
}

