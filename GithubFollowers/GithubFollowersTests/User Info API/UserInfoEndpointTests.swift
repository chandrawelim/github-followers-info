//
//  UserInfoEndpointTests.swift
//  GithubFollowersTests
//
//  Created by Chandra Welim on 16/06/25.
//

import XCTest
import GithubFollowers

final class UserInfoEndpointTests: XCTestCase {

    func test_userInfo_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!

        let received = UserInfoEndpoint.get(username: "chan").url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/users/chan")!

        XCTAssertEqual(received, expected)
    }
}
