//
//  FollowerMapperTests.swift
//  GithubFollowersTests
//
//  Created by Chandra Welim on 15/06/25.
//

import XCTest
import GithubFollowers

final class FollowerMapperTests: XCTestCase {

    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeFollowersJSON([])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try FollowerMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try FollowerMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWWithEmptyJSONList() throws {
        let emptyListJSON = makeFollowersJSON([])
        
        let result = try FollowerMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let user1 = makeUser(login: "KevinHock", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/3076393?v=4")!)
        let user2 = makeUser(login: "nhattri", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/6251989?v=4")!)

        let json = makeFollowersJSON([user1.json, user2.json])
        let result = try FollowerMapper.map(json, from: HTTPURLResponse(statusCode: 200))

        XCTAssertEqual(result, [user1.model, user2.model])
    }
    
    // MARK: - Helpers
    
    private func makeUser(login: String, avatarURL: URL) -> (model: Follower, json: [String: Any]) {
        let model = Follower(login: login, avatarUrl: avatarURL)

        let json: [String: Any] = [
            "login": login,
            "avatar_url": avatarURL.absoluteString
        ]

        return (model, json)
    }
    
    private func makeFollowersJSON(_ followers: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: followers)
    }
}


