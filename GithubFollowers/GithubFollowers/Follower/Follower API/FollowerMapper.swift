//
//  FollowerMapper.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

public final class FollowerMapper {
    
    private struct FollowerItem: Decodable {
        let login: String
        let avatarUrl: URL?

        private enum CodingKeys: String, CodingKey {
            case login
            case avatarUrl = "avatar_url"
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Follower] {
        guard response.isOK else {
            throw Error.invalidData
        }
        
        if let items = try? JSONDecoder().decode([FollowerItem].self, from: data) {
            return items.map { Follower(login: $0.login, avatarUrl: $0.avatarUrl) }
        } else {
            throw Error.invalidData
        }
    }
}
