//
//  RepositoryMapperTests.swift
//  GithubFollowersTests
//
//  Created by Chandra Welim on 16/06/25.
//

import XCTest
import GithubFollowers

final class RepositoryMapperTests: XCTestCase {

    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeRepositoriesJSON([])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try RepositoryMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try RepositoryMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeRepositoriesJSON([])
        
        let result = try RepositoryMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let repo1 = makeRepository(
            name: "swift-algorithms", 
            language: "Swift", 
            stars: 5890, 
            description: "Commonly used sequence and collection algorithms for Swift", 
            url: "https://github.com/apple/swift-algorithms",
            fork: false
        )
        let repo2 = makeRepository(
            name: "GitHub-Desktop", 
            language: "TypeScript", 
            stars: 19654, 
            description: "Focus on what matters instead of fighting with Git.", 
            url: "https://github.com/desktop/desktop",
            fork: false
        )

        let json = makeRepositoriesJSON([repo1.json, repo2.json])
        let result = try RepositoryMapper.map(json, from: HTTPURLResponse(statusCode: 200))

        XCTAssertEqual(result, [repo1.model, repo2.model])
    }
    
    func test_map_filtersOutForkedRepositories() throws {
        let originalRepo = makeRepository(
            name: "original-repo", 
            language: "Swift", 
            stars: 100, 
            description: "Original repository", 
            url: "https://github.com/user/original-repo",
            fork: false
        )
        let forkedRepo = makeRepository(
            name: "forked-repo", 
            language: "Swift", 
            stars: 50, 
            description: "Forked repository", 
            url: "https://github.com/user/forked-repo",
            fork: true
        )

        let json = makeRepositoriesJSON([originalRepo.json, forkedRepo.json])
        let result = try RepositoryMapper.map(json, from: HTTPURLResponse(statusCode: 200))

        XCTAssertEqual(result, [originalRepo.model])
    }
    
    func test_map_deliversItemsWithNilLanguageAndDescription() throws {
        let repo = makeRepository(
            name: "config-repo", 
            language: nil, 
            stars: 10, 
            description: nil, 
            url: "https://github.com/user/config-repo",
            fork: false
        )

        let json = makeRepositoriesJSON([repo.json])
        let result = try RepositoryMapper.map(json, from: HTTPURLResponse(statusCode: 200))

        XCTAssertEqual(result, [repo.model])
    }
    
    // MARK: - Helpers
    
    private func makeRepository(
        name: String, 
        language: String?, 
        stars: Int, 
        description: String?, 
        url: String,
        fork: Bool
    ) -> (model: Repo, json: [String: Any]) {
        let model = Repo(
            name: name, 
            language: language, 
            stars: stars, 
            description: description, 
            url: url
        )

        var json: [String: Any] = [
            "name": name,
            "stargazers_count": stars,
            "html_url": url,
            "fork": fork
        ]
        
        if let language = language {
            json["language"] = language
        }
        
        if let description = description {
            json["description"] = description
        }

        return (model, json)
    }
    
    private func makeRepositoriesJSON(_ repositories: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: repositories)
    }
}
