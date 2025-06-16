//
//  RepositoryEndpoint.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

public enum RepositoryEndpoint {
    case get(username: String)

    public func url(baseURL: URL) -> URL {
        switch self {
        case .get(let username):
            let userURL = baseURL.appendingPathComponent("/users/\(username)/repos")
            var components = URLComponents(url: userURL, resolvingAgainstBaseURL: true)!
            components.queryItems = [
                URLQueryItem(name: "per_page", value: "100"),
                URLQueryItem(name: "sort", value: "updated")
            ]
            return components.url!
        }
    }
}

