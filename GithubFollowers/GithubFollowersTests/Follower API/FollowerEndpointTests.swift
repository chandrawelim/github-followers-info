//
//  FollowerEndpointTests.swift
//  GithubFollowersTests
//
//  Created by Chandra Welim on 15/06/25.
//

import XCTest
import GithubFollowers

final class FollowerEndpointTests: XCTestCase {

    func test_getFollowers_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!
        let username = "chandrawelim"
        let page = 2

        let received = FollowerEndpoint.getFollowers(username: username, page: page).url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/users/chandrawelim/followers?per_page=100&page=2")!

        XCTAssertEqual(received, expected)
    }
}
