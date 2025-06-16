//
//  RepositoryEndpointTests.swift
//  GithubFollowersTests
//
//  Created by Chandra Welim on 16/06/25.
//

import XCTest
import GithubFollowers

final class RepositoryEndpointTests: XCTestCase {
    
    func test_getRepo_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!
        let username = "chandrawelim"

        let received = RepositoryEndpoint.get(username: username).url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/users/chandrawelim/repos?per_page=100&sort=updated")!

        XCTAssertEqual(received, expected)
    }
}

