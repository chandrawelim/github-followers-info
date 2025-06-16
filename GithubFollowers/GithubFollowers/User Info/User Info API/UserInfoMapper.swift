//
//  UserInfoMapper.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 16/06/25.
//

import Foundation

public final class UserInfoMapper {
    
    private struct UserInfoItem: Decodable {
        let login: String
        let avatarUrl: URL
        let name: String?
        let followers: Int
        let following: Int
        let location: String?
        let bio: String?
        let htmlUrl: String
        
        private enum CodingKeys: String, CodingKey {
            case login
            case avatarUrl = "avatar_url"
            case name
            case followers
            case following
            case location
            case bio
            case htmlUrl = "html_url"
        }
        
        var userInfo: UserInfo {
            return UserInfo(
                login: login,
                avatarUrl: avatarUrl,
                name: name,
                followers: followers,
                following: following,
                location: location,
                bio: bio,
                htmlUrl: htmlUrl
            )
        }
    }

    public enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> UserInfo {
        guard response.isOK, let item = try? JSONDecoder().decode(UserInfoItem.self, from: data) else {
            throw Error.invalidData
        }
        return item.userInfo
    }
}

