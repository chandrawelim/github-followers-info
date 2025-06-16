//
//  RepositoryMapper.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

import Foundation

public final class RepositoryMapper {

    private struct RepositoryItem: Decodable {
        let name: String
        let language: String?
        let stargazersCount: Int
        let description: String?
        let htmlUrl: String
        let fork: Bool

        private enum CodingKeys: String, CodingKey {
            case name
            case language
            case stargazersCount = "stargazers_count"
            case description
            case htmlUrl = "html_url"
            case fork
        }
    }

    public enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Repo] {
        guard response.isOK else {
            throw Error.invalidData
        }
        
        if let items = try? JSONDecoder().decode([RepositoryItem].self, from: data) {
            return items
                .filter { !$0.fork }  // ignore forks
                .map { Repo(name: $0.name,
                           language: $0.language,
                           stars: $0.stargazersCount,
                           description: $0.description,
                           url: $0.htmlUrl) }
        } else {
            throw Error.invalidData
        }
    }
}

