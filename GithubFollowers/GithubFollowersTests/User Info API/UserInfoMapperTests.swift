//
//  UserInfoMapperTests.swift
//  GithubFollowersTests
//
//  Created by Chandra Welim on 16/06/25.
//

import XCTest
import GithubFollowers

final class UserInfoMapperTests: XCTestCase {

    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeUserJSON(makeUser())
        let samples = [199, 201, 300, 400, 500]

        try samples.forEach { code in
            XCTAssertThrowsError(
                try UserInfoMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }

    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)

        XCTAssertThrowsError(
            try UserInfoMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }

    func test_map_deliversUserInfoOn200HTTPResponseWithJSONItems() throws {
        let user = makeUser(
            login: "chandrawelim",
            avatarURL: URL(string: "https://avatars.githubusercontent.com/u/9758498?v=4")!,
            name: "Chandra Welim",
            followers: 2,
            following: 2,
            location: "Indonesia",
            bio: "iOS Engineer",
            htmlUrl: "https://github.com/chandrawelim"
        )

        let json = makeUserJSON(user)
        let result = try UserInfoMapper.map(json, from: HTTPURLResponse(statusCode: 200))

        XCTAssertEqual(result, user.model)
    }

    func test_map_deliversUserInfoWithNullablesOn200HTTPResponse() throws {
        let user = makeUser(
            login: "chandrawelim",
            avatarURL: URL(string: "https://avatars.githubusercontent.com/u/9758498?v=4")!,
            name: nil,
            followers: 2,
            following: 2,
            location: nil,
            bio: nil,
            htmlUrl: "https://github.com/chandrawelim"
        )

        let json = makeUserJSON(user)
        let result = try UserInfoMapper.map(json, from: HTTPURLResponse(statusCode: 200))

        XCTAssertEqual(result, user.model)
    }

    // MARK: - Helpers

    private func makeUser(
        login: String = "chandrawelim",
        avatarURL: URL = URL(string: "https://example.com/avatar.jpg")!,
        name: String? = "Chandra",
        followers: Int = 10,
        following: Int = 20,
        location: String? = "Tokyo",
        bio: String? = "iOS Developer",
        htmlUrl: String = "https://github.com/chandrawelim"
    ) -> (model: UserInfo, json: [String: Any]) {
        let model = UserInfo(
            login: login,
            avatarUrl: avatarURL,
            name: name,
            followers: followers,
            following: following,
            location: location,
            bio: bio,
            htmlUrl: htmlUrl
        )

        var json: [String: Any] = [
            "login": login,
            "avatar_url": avatarURL.absoluteString,
            "followers": followers,
            "following": following,
            "html_url": htmlUrl
        ]

        if let name = name {
            json["name"] = name
        }
        if let location = location {
            json["location"] = location
        }
        if let bio = bio {
            json["bio"] = bio
        }

        return (model, json)
    }

    private func makeUserJSON(_ user: (model: UserInfo, json: [String: Any])) -> Data {
        return try! JSONSerialization.data(withJSONObject: user.json)
    }
}

